# Q1 : CPU
Constructeur INTEL, mod_le 12th Gen Intel(R) Core(TM) i9-12900
Famille de processeur : 6
   Thread(s) par cœur : 2
   Cœur(s) par socket : 16
    Socket(s) : 1
Puissance de base = 65W, donc 125/16 = 4,06W/c
Puissance turbo max = 202W 250/16 = 12,65W/c

# Q2 : GPU
NVIDIA GeForce RTX 3060
TDP: 170W et 3584 cores, donc 170/3584 = 0,04W/c

# Q3 : 170 + 65 = 235W

# Q4 : Libre 52G donc 52 * 0.3725 = 19.37

# Q5 : 

# Q6 : README.md: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 609/609 [00:00<00:00, 11.0MB/s]
dataset_infos.json: 1.65kB [00:00, 18.1MB/s]
data/train-00000-of-00001.parquet: 100%|███████████████████████████████████████████████████████████████████████████████████████████████████| 237M/237M [00:05<00:00, 46.4MB/s]
Generating train split: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████| 1000/1000 [00:00<00:00, 4090.24 examples/s]
------------------------------------------------------
Real Time: 44.3926 seconds
User Time: 44.0800 seconds
System Time: 16.7800 seconds

# Q8&9: mean : 85.9 + 87.3 + 85.5/3 = 86.233 |  variance = 0.596

# Q10: Faire un gros x40 sur la consommation d'une seule epoch donc process time moyen = 81s, real time moyen = 40.
POur la RAM on prends la puissance du GPU * le coeff
Usage moyen = 81/40 = 2.025 et *40 = 81 , c'est 86% le GPU, donc 1.74 

# Q11: process time moyen = 26s, real time moyen = 26
#usage moyen = 26/26 = 1, c'est 93% le GPU donc 0.93

# Q12: process time moyen = 93.616 real time moyen =93,5939 gpu usage = 96,59%
usage moyen = 93.616 / 93.5939 = 1 et GPU à 96.59% donc 0.9659 pour le GPU et RAM 0.9659 * 0.0044 = 0.0042 donc CPU = USAGE MOYEN - (GPU + RAM)
CPU à 3%

# Q13: 1000images/jour*365 jours = 365000 images/an
365000 * 0.964 = 351860 Wh = 351kWh

# Q16 : un tracker code carbon, valeurs pendant le training
aikahloul@voisin:/autofs/unitytravail/travail/aikahloul/M2/AISustain/files$ source /net/ens/python/miniconda3/bin/activate codecarbon
(codecarbon) aikahloul@voisin:/autofs/unitytravail/travail/aikahloul/M2/AISustain/files$ python TrainingDDPM_one_more_epoch_codecarbon.py 
README.md: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████| 609/609 [00:00<00:00, 2.49MB/s]
dataset_infos.json: 1.65kB [00:00, 5.97MB/s]
data/train-00000-of-00001.parquet: 100%|███████████████████████████████████████████████████████████████████████████████████| 237M/237M [00:04<00:00, 49.8MB/s]
Generating train split: 100%|████████████████████████████████████████████████████████████████████████████████████| 1000/1000 [00:00<00:00, 1258.26 examples/s]
[codecarbon INFO @ 15:58:47] [setup] RAM Tracking...
[codecarbon INFO @ 15:58:47] [setup] GPU Tracking...
[codecarbon INFO @ 15:58:47] Tracking Nvidia GPU via pynvml
[codecarbon INFO @ 15:58:47] [setup] CPU Tracking...
[codecarbon INFO @ 15:58:47] Tracking Intel CPU via RAPL interface
[codecarbon INFO @ 15:58:48] >>> Tracker's metadata:
[codecarbon INFO @ 15:58:48]   Platform system: Linux-7.1.8+deb13-amd64-x86_64-with-glibc2.41
[codecarbon INFO @ 15:58:48]   Python version: 3.11.5
[codecarbon INFO @ 15:58:48]   CodeCarbon version: 2.2.2
[codecarbon INFO @ 15:58:48]   Available RAM : 62.490 GB
[codecarbon INFO @ 15:58:48]   CPU count: 24
[codecarbon INFO @ 15:58:48]   CPU model: 12th Gen Intel(R) Core(TM) i9-12900
[codecarbon INFO @ 15:58:48]   GPU count: 1
[codecarbon INFO @ 15:58:48]   GPU model: 1 x NVIDIA GeForce RTX 3060
[codecarbon INFO @ 15:59:12] Energy consumed for RAM : 0.000004 kWh. RAM Power : 0.7296338081359863 W
[codecarbon INFO @ 15:59:12] Energy consumed for all GPUs : 0.000754 kWh. Total GPU Power : 135.71800000000002 W
[codecarbon INFO @ 15:59:12] Energy consumed for all CPUs : 0.000184 kWh. Total CPU Power : 33.13929463427613 W
[codecarbon INFO @ 15:59:12] 0.000943 kWh of electricity used since the beginning.
[codecarbon INFO @ 15:59:32] Energy consumed for RAM : 0.000008 kWh. RAM Power : 0.7674965858459473 W
[codecarbon INFO @ 15:59:32] Energy consumed for all GPUs : 0.001525 kWh. Total GPU Power : 138.724 W
[codecarbon INFO @ 15:59:32] Energy consumed for all CPUs : 0.000404 kWh. Total CPU Power : 39.498944710428844 W
[codecarbon INFO @ 15:59:32] 0.001937 kWh of electricity used since the beginning.
[codecarbon INFO @ 15:59:37] Energy consumed for RAM : 0.000009 kWh. RAM Power : 0.7782139778137208 W
[codecarbon INFO @ 15:59:37] Energy consumed for all GPUs : 0.001729 kWh. Total GPU Power : 141.13 W
[codecarbon INFO @ 15:59:37] Energy consumed for all CPUs : 0.000460 kWh. Total CPU Power : 39.0867144337513 W
[codecarbon INFO @ 15:59:37] 0.002199 kWh of electricity used since the beginning.
Total CPU energy consumption CodeCarbon (Process): 0.4602845632273589 Wh
Total RAM energy consumption CodeCarbon (Process): 0.00944168308569611 Wh
Total GPU energy consumption CodeCarbon (Process): 1.7294885096628134 Wh
Total Energy consumption CodeCarbon (Process): 2.1992147559758686 Wh
Emissions by CodeCarbon (Process): 0.12762922914830355 gCO2e

Pendant inférence 1 :

Real Time: 92.4327 seconds
User Time: 92.3300 seconds
System Time: 0.0900 seconds
mean gpu usage: 98 %

inf 2:

Real Time: 92.5906 seconds
User Time: 92.5300 seconds
System Time: 0.0600 seconds
mean gpu usage: 97.5652 %

inf 3:
[codecarbon INFO @ 16:16:44] [setup] RAM Tracking...
[codecarbon INFO @ 16:16:44] [setup] GPU Tracking...
[codecarbon INFO @ 16:16:44] Tracking Nvidia GPU via pynvml
[codecarbon INFO @ 16:16:44] [setup] CPU Tracking...
[codecarbon INFO @ 16:16:44] Tracking Intel CPU via RAPL interface
[codecarbon INFO @ 16:16:45] >>> Tracker's metadata:
[codecarbon INFO @ 16:16:45]   Platform system: Linux-7.1.8+deb13-amd64-x86_64-with-glibc2.41
[codecarbon INFO @ 16:16:45]   Python version: 3.11.5
[codecarbon INFO @ 16:16:45]   CodeCarbon version: 2.2.2
[codecarbon INFO @ 16:16:45]   Available RAM : 62.490 GB
[codecarbon INFO @ 16:16:45]   CPU count: 24
[codecarbon INFO @ 16:16:45]   CPU model: 12th Gen Intel(R) Core(TM) i9-12900
[codecarbon INFO @ 16:16:45]   GPU count: 1
[codecarbon INFO @ 16:16:45]   GPU model: 1 x NVIDIA GeForce RTX 3060
[codecarbon INFO @ 16:17:08] Energy consumed for RAM : 0.000002 kWh. RAM Power : 0.4432182312011719 W
[codecarbon INFO @ 16:17:08] Energy consumed for all GPUs : 0.000756 kWh. Total GPU Power : 135.923 W
[codecarbon INFO @ 16:17:08] Energy consumed for all CPUs : 0.000299 kWh. Total CPU Power : 53.77770232961172 W
[codecarbon INFO @ 16:17:08] 0.001057 kWh of electricity used since the beginning.
[codecarbon INFO @ 16:17:28] Energy consumed for RAM : 0.000005 kWh. RAM Power : 0.4432897567749024 W
[codecarbon INFO @ 16:17:28] Energy consumed for all GPUs : 0.001541 kWh. Total GPU Power : 141.347 W
[codecarbon INFO @ 16:17:28] Energy consumed for all CPUs : 0.000589 kWh. Total CPU Power : 52.122172275615725 W
[codecarbon INFO @ 16:17:28] 0.002135 kWh of electricity used since the beginning.
[codecarbon INFO @ 16:17:48] Energy consumed for RAM : 0.000007 kWh. RAM Power : 0.4433083534240723 W
[codecarbon INFO @ 16:17:48] Energy consumed for all GPUs : 0.002303 kWh. Total GPU Power : 137.116 W
[codecarbon INFO @ 16:17:48] Energy consumed for all CPUs : 0.000866 kWh. Total CPU Power : 49.92760416471498 W
[codecarbon INFO @ 16:17:48] 0.003176 kWh of electricity used since the beginning.
[codecarbon INFO @ 16:18:08] Energy consumed for RAM : 0.000010 kWh. RAM Power : 0.4433197975158692 W
[codecarbon INFO @ 16:18:08] Energy consumed for all GPUs : 0.003096 kWh. Total GPU Power : 142.905 W
[codecarbon INFO @ 16:18:08] Energy consumed for all CPUs : 0.001105 kWh. Total CPU Power : 43.03487392096815 W
[codecarbon INFO @ 16:18:08] 0.004211 kWh of electricity used since the beginning.
[codecarbon INFO @ 16:18:25] Energy consumed for RAM : 0.000012 kWh. RAM Power : 0.44405221939086914 W
[codecarbon INFO @ 16:18:25] Energy consumed for all GPUs : 0.003773 kWh. Total GPU Power : 142.467 W
[codecarbon INFO @ 16:18:25] Energy consumed for all CPUs : 0.001304 kWh. Total CPU Power : 41.92864270239995 W
[codecarbon INFO @ 16:18:25] 0.005089 kWh of electricity used since the beginning.
Total CPU energy consumption CodeCarbon (Process): 1.304025313219416 Wh
Total RAM energy consumption CodeCarbon (Process): 0.011952995236840897 Wh
Total GPU energy consumption CodeCarbon (Process): 3.7727005251332124 Wh
Total Energy consumption CodeCarbon (Process): 5.088678833589469 Wh
Emissions by CodeCarbon (Process): 0.2953163874285313 gCO2e
Real Time: 101.4487 seconds
User Time: 97.0300 seconds
System Time: 0.1600 seconds
mean gpu usage: 95.4167 %

green algorithm :
Carbon intensity : 0.3344 gCO₂eq/Wh



