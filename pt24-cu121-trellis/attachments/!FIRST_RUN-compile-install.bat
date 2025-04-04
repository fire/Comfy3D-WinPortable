@REM Edit this to your GPU arch.
@REM You don't need to add the "+PTX". Here it works as a fail-safe (providing forward compatibility).

set TORCH_CUDA_ARCH_LIST=6.1+PTX

@REM ===========================================================================

set CMAKE_ARGS=-DBUILD_opencv_world=ON -DWITH_CUDA=ON -DCUDA_FAST_MATH=ON -DWITH_CUBLAS=ON -DWITH_NVCUVID=ON
set PATH=%PATH%;%~dp0\python_embeded\Scripts

@REM Compile-install PyTorch3D
@REM PyTorch3D on Windows works best through compile-install. Binary-install will fail on some workflows.
@REM e.g. "CUDA error: no kernel image is available for execution on the device"

.\python_embeded\python.exe -s -m pip install --force-reinstall ^
 .\extras\pytorch3d

@REM Compile-install pointnet2_ops for Triplane Gaussian

.\python_embeded\python.exe -s -m pip install --force-reinstall ^
 .\extras\pointnet2_ops

@REM Compile-install simple-knn for Gaussian Splatting

.\python_embeded\python.exe -s -m pip install --force-reinstall ^
 .\extras\simple-knn

@REM ===========================================================================
@REM For TRELLIS
@REM Note here we skipped 'utils3d'

@REM vox2seq

.\python_embeded\python.exe -s -m pip install --force-reinstall ^
 .\extras\vox2seq

@REM diff-gaussian-rasterization

.\python_embeded\python.exe -s -m pip install --force-reinstall ^
 .\extras\diff-gaussian-rasterization

@REM Differential Octree Rasterization

.\python_embeded\python.exe -s -m pip install ^
 .\extras\diffoctreerast

@REM ===========================================================================

.\python_embeded\python.exe -s -m pip install numpy==1.26.4
