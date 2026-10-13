import torchvision
import torch
import torchvision.transforms as transforms
from torchvision.datasets import Caltech101
from torch.utils.data import DataLoader, random_split


# TODO - Step 2: implement the data loader class with the following methods
#   - The constructor must have a `root` parameter to locate the data and a bool `download` (False by default) to download the data.
#   - "training_loader": the data loader for the CalTech101 training dataset
#   - "validation_loader": the data loader for the CalTech101 validation dataset
#   Note: You can modify the method prototypes if needed.
class Caltech101DataLoader:
    def __init__(self, root: str):
        self.root = root
        self.download = True

        transform = transforms.Compose([
                    transforms.Resize((128, 128)),
                    transforms.ToTensor(),
                ])

        full_dataset = torchvision.datasets.Caltech101(
                    root=self.root, 
                    download=self.download,
                    transform=transform
                )

        train_size = int(0.8 * len(full_dataset))
        val_size = len(full_dataset) - train_size
        self.train_dataset, self.val_dataset = random_split(
                    full_dataset, [train_size, val_size]
                )

        self.classes = len(full_dataset.categories)

    def training_loader(self):
        trainloader = torch.utils.data.DataLoader(
            self.train_dataset, batch_size=64, shuffle=True, num_workers=2)
        
    def validation_loader(self):
        valloader = torch.utils.data.DataLoader(
            self.val_dataset, batch_size=64, shuffle=True, num_workers=2)
"""
, and two data augmentation parameters `input_transform` and `target_transform`
#       that will be applied to image and labels respectively during training.   """