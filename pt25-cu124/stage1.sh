#!/bin/bash
set -eux

# Chores
git config --global core.autocrlf true
gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'
workdir=$(pwd)
pip_exe="${workdir}/python_standalone/python.exe -s -m pip"
export PYTHONPYCACHEPREFIX="${workdir}/pycache1"
export PATH="$PATH:$workdir/python_standalone/Scripts"
export PIP_NO_WARN_SCRIPT_LOCATION=0

ls -lahF

# Download Python Standalone
cd "$workdir"
curl -sSL \
https://github.com/astral-sh/python-build-standalone/releases/download/20250115/cpython-3.12.8+20250115-x86_64-pc-windows-msvc-shared-install_only.tar.gz \
    -o python.tar.gz
tar -zxf python.tar.gz
mv python python_standalone

# Download 3D-Pack
# Note: zip archive doesn't contain the ".git" folder, it's not upgradable.
cd "$workdir"
curl -sSL https://github.com/YanWenKun/ComfyUI-3D-Pack/archive/0601d2165fa906d7c1013925f9182b75d99972a1.zip \
    -o ComfyUI-3D-Pack-0601d2165fa906d7c1013925f9182b75d99972a1.zip
unzip -q ComfyUI-3D-Pack-0601d2165fa906d7c1013925f9182b75d99972a1.zip
mv ComfyUI-3D-Pack-0601d2165fa906d7c1013925f9182b75d99972a1 ComfyUI-3D-Pack
rm ComfyUI-3D-Pack-0601d2165fa906d7c1013925f9182b75d99972a1.zip

cd "$workdir"
curl -sSL https://github.com/MrForExample/Comfy3D_Pre_Builds/archive/ac9f238f092b94ba319ce06f3ccd80b9d0f6c8c4.zip \
    -o Comfy3D_Pre_Builds-ac9f238f092b94ba319ce06f3ccd80b9d0f6c8c4.zip
unzip -q Comfy3D_Pre_Builds-ac9f238f092b94ba319ce06f3ccd80b9d0f6c8c4.zip
mv Comfy3D_Pre_Builds-ac9f238f092b94ba319ce06f3ccd80b9d0f6c8c4 Comfy3D_Pre_Builds
rm Comfy3D_Pre_Builds-ac9f238f092b94ba319ce06f3ccd80b9d0f6c8c4.zip

# PIP installs
$pip_exe install --upgrade pip wheel setuptools

$pip_exe install -r "$workdir"/pak2.txt
$pip_exe install -r "$workdir"/pak3.txt
$pip_exe install -r "$workdir"/pak4.txt
$pip_exe install -r "$workdir"/pak5.txt
$pip_exe install -r "$workdir"/pak6.txt

cd "$workdir"/Comfy3D_Pre_Builds/_Build_Wheels/_Wheels_win_py312_torch2.5.1_cu124/
rm torch_scatter-2.1.2-cp312-cp312-win_amd64.whl
$pip_exe install diff_gaussian_rasterization-0.0.0-cp312-cp312-win_amd64.whl
$pip_exe install kiui-0.2.14-py3-none-any.whl
$pip_exe install nvdiffrast-0.3.3-py3-none-any.whl
$pip_exe install pointnet2_ops-3.0.0-cp312-cp312-win_amd64.whl
$pip_exe install pytorch3d-0.7.8-cp312-cp312-win_amd64.whl
$pip_exe install simple_knn-0.0.0-cp312-cp312-win_amd64.whl
$pip_exe install vox2seq-0.0.0-cp312-cp312-win_amd64.whl
cd "$workdir"

$pip_exe install -r "$workdir"/pak8.txt
$pip_exe install -r "$workdir"/pak9.txt
$pip_exe install -r "$workdir"/pakA.txt
$pip_exe install -r "$workdir"/pakB.txt

$pip_exe list

# Add Ninja binary (replacing PIP Ninja)
## EXE wrappers in 'python_standalone\Scripts\' are not portable, they will look for 'C:\Absolute\Path\python.exe'.
## So here we use the actual binary of Ninja.
## What's more, if the end-user re-install/upgrade the PIP Ninja, the path problem will be fixed automatically.
curl -sSL https://github.com/ninja-build/ninja/releases/latest/download/ninja-win.zip \
    -o ninja-win.zip
unzip -q -o ninja-win.zip -d "$workdir"/python_standalone/Scripts
rm ninja-win.zip

# Add aria2 binary
curl -sSL https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0-win-64bit-build1.zip \
    -o aria2.zip
unzip -q aria2.zip -d "$workdir"/aria2
mv "$workdir"/aria2/*/aria2c.exe  "$workdir"/python_standalone/Scripts/
rm aria2.zip

# Add FFmpeg binary
curl -sSL https://github.com/GyanD/codexffmpeg/releases/download/7.1/ffmpeg-7.1-full_build.zip \
    -o ffmpeg.zip
unzip -q ffmpeg.zip -d "$workdir"/ffmpeg
mv "$workdir"/ffmpeg/*/bin/ffmpeg.exe  "$workdir"/python_standalone/Scripts/
rm ffmpeg.zip

cd "$workdir"

ls -lahF
