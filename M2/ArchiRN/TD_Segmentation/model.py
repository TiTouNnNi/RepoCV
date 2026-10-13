
import torch


class UNet(torch.nn.Module):
    """
    This class will implement the UNet architecture as presented in the course.


    Rq: As in the previous TPs, there is no softmax layer.
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        raise NotImplementedError(f"{self.__class__.__name__} is not implemented.")

    def forward(self, x):
        raise NotImplementedError("'forward' method not implemented.")
