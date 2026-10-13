---
license: mit
tags:
- pytorch
- diffusers
- unconditional-image-generation
- diffusion-models-class
- butterflies
---

# Model Card for utkarshsinha/ddpm-butterflies-128

This is an unconditional diffusion model trained on a dataset of butterflies 🦋 as part of the "Training with Diffusers" guide.

## Usage

```python
from diffusers import DDPMPipeline
import torch

# Make sure to use your actual repo ID
pipeline = DDPMPipeline.from_pretrained("utkarshsinha/ddpm-butterflies-128", torch_dtype=torch.float16)
pipeline.to("cuda")

image = pipeline().images[0]
image
