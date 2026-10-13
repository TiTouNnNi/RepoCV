""" TD1: Script d'entraînement d'un réseau de neurones convolutifs (CNN) pour de la classification des images
Objectifs:
- Prise en main de l'API de PyTorch
- Implémentation de la boucle d'entraînement et de validation from scratch
"""
import torch
import torchvision
import torch.optim as optim
import torch.nn as nn
import torchvision.transforms as transforms
from torchmetrics.classification import MulticlassAccuracy

from data import Caltech101DataLoader
from model import BasicConvNet

# Hyper-parameters
n_epoch = 1
device = "cuda" if torch.cuda.is_available() else "cpu"
best_model_params_path = 'best_model_params.pt'

# TODO - Step 1: Define Pre-processing or input data and target labels:
#   - Using torchvision.transforms data augmentation classes, implement the following transformation on inputs:
#       - Data type conversion to float32
transform = transforms.ConvertImageDtype(torch.float32)

#input_transform = transforms.RandomCrop()
#target_transform = transforms.RandomCrop()

# TODO - Step 2: Implement the data loader
#   - In "data.py" file, implement the Caltech101DataLoader class
#   - Use this class to retrieve both training and validation data loader
caltech_dataset = Caltech101DataLoader("../Caltech")  # Change that path to one better fitting
train_loader = caltech_dataset.training_loader()
val_loader = caltech_dataset.validation_loader()
n_classes = caltech_dataset.classes
print(n_classes)

# TODO - Step 3: Implement the model
#   - In "model.py" file, implement the BasicConvNet class
model = BasicConvNet().to(device=device)

# TODO - Step 4: Training configuration
#   - Define the loss function (cf "CrossEntropyLoss" class)
#   - Define the optimiser (SGD with learning rate of 10e-2)
#   - Define the metrics (Accuracy)
optimizer = optim.Adam(model.parameters(), lr=0.001)
criterion = nn.CrossEntropyLoss()
train_accuracy_metric = MulticlassAccuracy(num_classes=n_classes, average="micro").to(device)
val_accuracy_metric = MulticlassAccuracy(num_classes=n_classes, average="micro").to(device)
test_accuracy_metric = MulticlassAccuracy(num_classes=n_classes, average="micro").to(device)

# TODO - Step 5: Implement the training loop and the validation loop
#   - Fill the missing TODOs in the following code
torch.save(model.state_dict(), best_model_params_path)
best_acc = 0.

for epoch in range(1, n_epoch + 1):
    print(f'Epoch {epoch:02d}/{n_epoch:02d}')
    print('-' * 10)

    # TODO - 5.1: Training loop
    #   - Implement each of the following steps
    model.train()
    train_ma_loss = 0.
    train_ma_acc = 0.
    best_val_acc = 0.
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
        print(f"\r{step+1:03d}/{len(train_loader):03d}: loss = {train_ma_loss:.4f} - acc (train) = {train_ma_acc:.4f}", end="")
    print()  # new line

    val_loss = 0.
    val_acc = 0.
    print("Validation starts...")
    # TODO - 5.2: Validation loop
    for step, (inp, out) in enumerate(val_loader):
        # TODO: put data to the correct device

        # TODO: Perform forward pass

        # TODO: Compute loss function between predictions and ground truth

        # TODO: Update moving average loss and accuracy
        print(f"\r{step+1:03d}/{len(train_loader):03d}: loss = {val_loss:.4f} - acc (train) = {val_acc:.4f}", end="")
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
