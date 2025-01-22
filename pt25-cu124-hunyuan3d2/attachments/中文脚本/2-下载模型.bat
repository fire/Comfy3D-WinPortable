@REM 使用国内镜像站点
set HF_ENDPOINT=https://hf-mirror.com

@REM 复制 u2net.onnx 到用户主目录下，以免启动时还需下载。
IF NOT EXIST "%USERPROFILE%\.u2net\u2net.onnx" (
    IF EXIST ".\extras\u2net.onnx" (
        mkdir "%USERPROFILE%\.u2net" 2>nul
        copy ".\extras\u2net.onnx" "%USERPROFILE%\.u2net\u2net.onnx"
    )
)

@REM 如需启用 HF Hub 实验性高速传输，取消该行注释。仅在千兆比特以上网速有意义。
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

set HF_HUB_CACHE=%~dp0\HuggingFaceHub

set PATH=%PATH%;%~dp0\python_standalone\Scripts

@REM 下载 Hunyuan3D-2 模型
.\python_standalone\Scripts\huggingface-cli.exe download "tencent/Hunyuan3D-2"

@REM 下载 文生3D 所需模型
rem .\python_standalone\Scripts\huggingface-cli.exe download "Tencent-Hunyuan/HunyuanDiT-v1.1-Diffusers-Distilled"
