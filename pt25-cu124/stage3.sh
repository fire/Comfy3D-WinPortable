#!/bin/bash
set -eux

ls -lahF

du -hd1 Comfy3D_WinPortable

"C:\Program Files\7-Zip\7z.exe" a -t7z -m0=lzma2 -mx=5 -mfb=32 -md=32m -ms=on -mf=BCJ2 -v2146435072b Comfy3D_WinPortable.7z Comfy3D_WinPortable

ls -lahF
