#!/bin/bash
set -eux

# Chores
gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'
workdir=$(pwd)
python_exe="${workdir}/Hunyuan3D2_WinPortable/python_standalone/python.exe"
export PYTHONPYCACHEPREFIX="${workdir}/pycache2"
export PATH="$PATH:$workdir/Hunyuan3D2_WinPortable/python_standalone/Scripts"

# MKDIRs
mkdir -p "$workdir"/Hunyuan3D2_WinPortable/extras
export HF_HUB_CACHE="$workdir/Hunyuan3D2_WinPortable/HuggingFaceHub"
mkdir -p "${HF_HUB_CACHE}"
export TORCH_HOME="$workdir/Hunyuan3D2_WinPortable/TorchHome"
mkdir -p "${TORCH_HOME}"

# Relocate python_standalone
mv  "$workdir"/python_standalone  "$workdir"/Hunyuan3D2_WinPortable/python_standalone

# Download Hunyuan3D-2
cd "$workdir"/Hunyuan3D2_WinPortable/
$gcs https://github.com/YanWenKun/Hunyuan3D-2.git

# Download u2net model needed by rembg (to avoid download at first start)
curl -sSL https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx \
    -o "$workdir"/Hunyuan3D2_WinPortable/extras/u2net.onnx

# Copy & overwrite attachments
cp -rf "$workdir"/attachments/. \
    "$workdir"/Hunyuan3D2_WinPortable/

cd "$workdir"
