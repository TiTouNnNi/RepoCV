""" TD1: Script d'entraînement d'un réseau de neurones convolutifs (CNN) pour de la classification des images
Objectifs:
- Prise en main de l'API de PyTorch
- Implémentation de la boucle d'entraînement et de validation from scratch
"""
import torch
import torchvision
from torch.utils.data import DataLoader
import torchvision.transforms as transforms
from torchvision.transforms import InterpolationMode

from model import UNet

# Hyper-parameters
n_epoch = 1
device = "cuda" if torch.cuda.is_available() else "cpu"
best_model_params_path = 'best_model_params.pt'

# TODO - Step 1: Define Pre-processing or input data and target labels:
#   - Using torchvision.transforms data augmentation classes, implement the following transformation on inputs:
#       - resize all images to 224x224 (bilinear interpolation)
#       - convert to RBG
#       - convert to tensor
#   - Implement the following transformation on masks
#       - resize all masks to 224x224 (nearest interpolation)
#       - convert to tensor

input_transform = transforms.Compose([transforms.Resize((224,224), interpolation = InterpolationMode.BILLINEAR),
                                      transforms.Lambda(lambda img: img.convert('RGB')),
                                      transforms.ToTensor()])
target_transform = transforms.Compose([transforms.Resize((224,224), interpolation = InterpolationMode.NEAREST),
                                      transforms.ToTensor()])

# TODO - Step 2: Implement the data loader
#   - Using ``VOCSegmentation`` class from torchvision, get the VOC2007 training and validation dataset
root = '/net/ens/amelip/datasets/VOCdevkit/VOC20007'
train_dataset = torchvision.datasets.VOCSegmentation(root,'2007','train', False, input_transform, target_transform)
val_dataset = torchvision.datasets.VOCSegmentation(root,'2007','val', False, input_transform, target_transform)

batch_size = 8
#UpSamplingBillinear2D

train_loader = DataLoader(
    dataset = train_dataset,
    batch_size = batch_size,
    shuffle = True,
    num_workers = 4 
)
val_loader = DataLoader(
    dataset = val_dataset,
    batch_size = batch_size,
    shuffle = True,
    num_workers = 4 
)

# TODO - Step 3: Implement the model
#   - In "model.py" file, implement the BasicConvNet class
model = UNet().to(device=device)

# TODO - Step 4: Training configuration
#   - Define the loss function (cf "CrossEntropyLoss" class)
#   - Define the optimiser (SGD with learning rate of 10e-2)
#   - Define mean IOU from ``torchmetrics.segmentation``

# TODO - Step 5: Implement the training loop and the validation loop
#   - Fill the missing TODOs in the following code
torch.save(model.state_dict(), best_model_params_path)
best_val_acc = 0.
for epoch in range(1, n_epoch + 1):
    print(f'Epoch {epoch:02d}/{n_epoch:02d}')
    print('-' * 10)

    # TODO - 5.1: Training loop
    #   - Implement each of the following steps
    model.train()
    train_acc_loss = 0.
    train_ma_acc = 0.
    print("Training starts...")
    for step, (inp, out) in enumerate(train_loader):
        # TODO: put data to the correct device
        inp = inp.to(device)
        out = out.to(device)

        # TODO: Reset gradients stored in the optimiser

        # TODO: Perform forward pass

        # TODO: Compute loss function between predictions and ground truth

        # TODO: Do backpropagation

        # TODO: Update optimiser internal parameters

        # TODO: Update moving average loss and accuracy
        print(f"\r{step+1:03d}/{len(train_loader):03d}: loss = {train_acc_loss / (step + 1):.4f} - acc (train) = {train_ma_acc:.4f}", end="")
    print()  # new line

    val_acc_loss = 0.
    val_acc = 0.
    print("Validation starts...")
    # TODO - 5.2: Validation loop
    for step, (inp, out) in enumerate(val_loader):
        # TODO: put data to the correct device

        # TODO: Perform forward pass

        # TODO: Compute loss function between predictions and ground truth

        # TODO: Update moving average loss and accuracy
        print(f"\r{step+1:03d}/{len(val_loader):03d}: loss = {val_acc_loss / (step + 1):.4f} - acc (train) = {val_acc:.4f}", end="")
    print()  # new line

    if best_val_acc < val_acc:
        torch.save(model.state_dict(), best_model_params_path)
        print(f"Saving model with better perfs ({best_val_acc} -> {val_acc}")
        best_val_acc = val_acc

# TODO - Bonus steps:
#   - Improve data augmentation by adding random crop, random flip, etc.
#   - Try different ConvNet architectures
#   - Try other optimisers (Adam, RMSProp, ...) and learning rate
#   - Add learning rate scheduling (cf "torch.optim.lr_scheduler")
