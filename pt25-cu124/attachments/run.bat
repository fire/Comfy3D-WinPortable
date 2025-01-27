@REM Edit this first! According to your GPU.
set TORCH_CUDA_ARCH_LIST=8.9

@REM To set HuggingFace Access Token, uncomment and edit the line below.
@REM https://huggingface.co/settings/tokens
rem set HF_TOKEN=

@REM Set the correct path for CUDA Toolkit if you install it elsewhere.
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4

@REM To set proxy, edit and uncomment the two lines below (remove 'rem ' in the beginning of line).
rem set HTTP_PROXY=http://localhost:1081
rem set HTTPS_PROXY=http://localhost:1081

@REM To set mirror site for PIP & HuggingFace Hub, uncomment and edit the two lines below.
rem set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
rem set HF_ENDPOINT=https://hf-mirror.com

@REM To enable HuggingFace Hub's experimental high-speed file transfer, uncomment the line below.
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

@REM ===========================================================================
@REM These settings usually don't need change.

@REM This command redirects HuggingFace-Hub to download model files in this folder.
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM This command redirects Pytorch Hub to download model files in this folder.
set TORCH_HOME=%~dp0\TorchHome

@REM This command will set PATH environment variable.
set PATH=%PATH%;%~dp0\python_standalone\Scripts
set PATH=%PATH%;%CUDA_HOME%\bin

@REM This command will set include path for NVRTC compiler, crucial for cumm - spconv - TRELLIS
@REM https://github.com/traveller59/spconv#prebuilt-gpu-support-matrix
@REM https://github.com/traveller59/spconv/blob/master/docs/PURE_CPP_BUILD.md
set CUMM_INCLUDE_PATH=%~dp0\python_standalone\Lib\site-packages\cumm\include

@REM This command will let the .pyc files to be stored in one place.
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM ===========================================================================
@REM Start ComfyUI

@REM If you don't want the browser to open automatically, add [ --disable-auto-launch ] to the end of the line below.
.\python_standalone\python.exe -s ComfyUI\main.py --windows-standalone-build 

pause
