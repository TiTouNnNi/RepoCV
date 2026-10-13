import psutil
from diffusers import DDPMPipeline
import time
# from PIL import Image
import torch
from codecarbon import EmissionsTracker

from diffusers.utils import logging
logging.disable_progress_bar()


pipeline = DDPMPipeline.from_pretrained('ddpm-butterflies-128')
pipeline.set_progress_bar_config(disable=True)
pipeline = pipeline.to("cuda")

p = psutil.Process()  # current process
start = time.time()
tracker = EmissionsTracker(measure_power_secs=20, tracking_mode="process")
tracker.start()
user_start = p.cpu_times().user
system_start = p.cpu_times().system
image = pipeline(
    batch_size=5,  # one result image
    generator=torch.manual_seed(0),
)


end = time.time()
user_end = p.cpu_times().user
system_end = p.cpu_times().system

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
print('------------------------------------------------------')
print('Real Time: {:.4f} seconds'.format(end-start))
print('User Time: {:.4f} seconds'.format(user_end-user_start))
print('System Time: {:.4f} seconds'.format(system_end-system_start))

for i, img in enumerate(image.images):
    img.save("result_%02d.png" % i)
