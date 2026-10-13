#!/usr/bin/env python3
"""
Build script for Kamek C++ Twitch Crowd Control mod.
Adapted for GCC (devkitPPC) on Windows.
"""

from pathlib import Path
import subprocess
import sys
import yaml

# Use 'project.yaml' by default if no arguments are provided.
project_path = sys.argv[1] if len(sys.argv) > 1 else 'project.yaml'
project_name = project_path.rstrip('.yaml')

with open(project_path, 'r', encoding='utf-8') as f:
    project_data = yaml.safe_load(f)

if not isinstance(project_data, dict):
    raise ValueError('Error: The project file is in an invalid format (it should be a YAML mapping).')
if 'output_dir' not in project_data:
    raise ValueError('Error: Missing output_dir field in the project file.')

asm_folder = Path(project_data['output_dir'])

# Set up GCC (devkitPPC) paths.
if sys.platform == 'win32':
    # Default installation path for devkitPro on Windows.
    gccpath = Path('C:\\devkitPro\\devkitPPC\\bin\\')
    kamekopts = ['--gcc-append-exe']
else:
    # Linux/WSL path fallback.
    gccpath = Path('/opt/devkitpro/devkitPPC/bin/')
    kamekopts = []

print(f"Compiling project '{project_name}' using devkitPPC...")

# Call Kamek using strictly GCC (removed CodeWarrior dependencies).
res = subprocess.run([
    sys.executable, 
    'tools/kamek.py', 
    project_path, 
    '--show-cmd', 
    '--no-rels', 
    f'--gcc-path={gccpath}', 
    '--gcc-type=powerpc-eabi', 
    # c++filt is a standard GCC tool to demangle C++ names.
    '--filt-path=tools/c++filt', 
    *kamekopts
])

if res.returncode == 0:
    print('✅ Compilation successful! Check the output directory for Riivolution files.')
else:
    print('❌ Compilation failed. Check the errors above.')
    exit(1)