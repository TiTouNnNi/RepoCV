
import torch.nn as nn
import torch


class BasicConvNet(torch.nn.Module):
    """
    This class will implement the following ConvNet architecture (all Conv layers are followed by ReLU):
    - Conv2d with 7x7 kernel size, 32 filters, and stride 2
    - Conv2d with 3x3 kernel size, 32 filters, and stride 1
    - Conv2d with 3x3 kernel size, 64 filters, and stride 1
    - Max pooling with 2x2 kernel size, stride 2
    - Conv2d with 3x3 kernel size, 128 filters, and stride 1
    - Conv2d with 3x3 kernel size, 128 filters, and stride 1
    - Flatten
    - Linear layer without activation, as many filters as there are classes

    Rq: We don't add a softmax layer because the cross-entropy loss can be used without (in fact, it improves numerical stability when computing gradients)
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Define the convolutional and fully connected layers
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=32, kernel_size=7,stride=2)
        self.conv2 = nn.Conv2d(in_channels=32, out_channels=32, kernel_size=3, stride=1)
        self.conv3 = nn.Conv2d(in_channels=32, out_channels=64, kernel_size=3, stride=1)
        self.pool1 = nn.MaxPool2d(kernel_size=2,stride=2)
        self.conv4 = nn.Conv2d(in_channels=64, out_channels=128, kernel_size=3, stride=1)
        self.conv5 = nn.Conv2d(in_channels=128, out_channels=128, kernel_size=3, stride=1)
        self.flatten = nn.Flatten()

        dummy_tensor = torch.zeros(1, 3, 128, 128)

        with torch.no_grad():
            dummy_tensor = self.conv1(dummy_tensor)
            dummy_tensor = self.conv2(dummy_tensor)
            dummy_tensor = self.conv3(dummy_tensor)
            dummy_tensor = self.pool1(dummy_tensor)
            dummy_tensor = self.conv4(dummy_tensor)
            dummy_tensor = self.conv5(dummy_tensor)
            
            # The tensor shape is now (1, 128, final_height, final_width)
            H = dummy_tensor.shape[2]
            W = dummy_tensor.shape[3]

        self.fc1 = nn.Linear(in_features=128*H*W, out_features=102)
        self.relu = nn.ReLU()


    def forward(self, x):
      x = self.relu(self.conv1(x))
      x = self.relu(self.conv2(x))
      x = self.relu(self.conv3(x))
      x = self.pool1(x)
      x = self.relu(self.conv4(x))
      x = self.relu(self.conv5(x))
      x = self.flatten(x)
      x = self.fc1(x)
      return x
