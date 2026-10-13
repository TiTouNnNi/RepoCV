from codecarbon import EmissionsTracker
import torch
from dataclasses import dataclass
from datasets import load_dataset
from torchvision import transforms
from diffusers.optimization import get_cosine_schedule_with_warmup
from huggingface_hub.utils import logging
logging.set_verbosity_error()
from diffusers import DDPMPipeline
from accelerate import Accelerator
from accelerate.utils import ProjectConfiguration
import torch.nn.functional as F
from diffusers.utils import logging
logging.disable_progress_bar()


@dataclass
class TrainingConfig:
    dataset_name = "huggan/smithsonian_butterflies_subset"
    image_size = 128  # the generated image resolution
    train_batch_size = 16
    gradient_accumulation_steps = 1
    learning_rate = 1e-4
    lr_warmup_steps = 500
    mixed_precision = 'fp16'  # automatic mixed precision
    model_dir = 'ddpm-butterflies-128'  # the model name locally
    overwrite_model_dir = True  # overwrite the old model when re-running
    seed = 0


config = TrainingConfig()
dataset = load_dataset(config.dataset_name, split="train")

preprocess = transforms.Compose(
    [
        transforms.Resize((config.image_size, config.image_size)),
        transforms.RandomHorizontalFlip(),
        transforms.ToTensor(),
        transforms.Normalize([0.5], [0.5]),
    ]
)


def transform(examples):
    images = [preprocess(image.convert("RGB")) for image in examples["image"]]
    return {"images": images}


dataset.set_transform(transform)
train_dataloader = torch.utils.data.DataLoader(
    dataset,
    batch_size=config.train_batch_size,
    shuffle=True
)
pipeline = DDPMPipeline.from_pretrained(config.model_dir)
pipeline.set_progress_bar_config(disable=True)
model = pipeline.unet
noise_scheduler = pipeline.scheduler
optimizer = torch.optim.AdamW(model.parameters(), lr=config.learning_rate)
lr_scheduler = get_cosine_schedule_with_warmup(
    optimizer=optimizer,
    num_warmup_steps=config.lr_warmup_steps,
    num_training_steps=len(train_dataloader)
)


accelerator_project_config = ProjectConfiguration(project_dir=config.model_dir)
accelerator = Accelerator(
    mixed_precision=config.mixed_precision,
    gradient_accumulation_steps=config.gradient_accumulation_steps,
    project_config=accelerator_project_config,
)
if accelerator.is_main_process:
    model, optimizer, train_dataloader, lr_scheduler = accelerator.prepare(
        model,
        optimizer,
        train_dataloader,
        lr_scheduler
    )

    # Create Carbon tracker
    tracker = EmissionsTracker(measure_power_secs=20, tracking_mode="process")
    tracker.start()
    # Train the model
    for step, batch in enumerate(train_dataloader):

        clean_images = batch['images']
        # Sample noise to add to the images
        noise = torch.randn(clean_images.shape).to(clean_images.device)
        bs = clean_images.shape[0]

        # Sample a random timestep for each image
        timesteps = torch.randint(
            0, noise_scheduler.config.num_train_timesteps, (bs,), device=clean_images.device).long()

        # Add noise to the clean images according to the noise magnitude at each timestep
        # (this is the forward diffusion process)
        noisy_images = noise_scheduler.add_noise(
            clean_images, noise, timesteps)

        with accelerator.accumulate(model):
            # Predict the noise residual
            noise_pred = model(noisy_images, timesteps, return_dict=False)[0]
            loss = F.mse_loss(noise_pred, noise)
            accelerator.backward(loss)

            accelerator.clip_grad_norm_(model.parameters(), 1.0)
            optimizer.step()
            lr_scheduler.step()
            optimizer.zero_grad()

        # logs = {"loss": loss.detach().item(), "lr": lr_scheduler.get_last_lr()[0]}


emissions: float = tracker.stop()

print('Total CPU energy consumption CodeCarbon (Process): ' +
      str(tracker._total_cpu_energy.kWh*1000) + ' Wh')
print('Total RAM energy consumption CodeCarbon (Process): ' +
      str(tracker._total_ram_energy.kWh*1000) + ' Wh')
print('Total GPU energy consumption CodeCarbon (Process): ' +
      str(tracker._total_gpu_energy.kWh*1000) + ' Wh')
print('Total Energy consumption CodeCarbon (Process): ' +
      str(tracker._total_energy.kWh*1000) + ' Wh')
print('Emissions by CodeCarbon (Process): ' + str(emissions*1000) + ' gCO2e')


pipeline.save_pretrained(config.model_dir)
