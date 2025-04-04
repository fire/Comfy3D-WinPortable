#!/bin/bash
set -eu

echo '#' > requirements5.txt

array=(
https://github.com/comfyanonymous/ComfyUI/raw/refs/heads/master/requirements.txt
https://github.com/MrForExample/ComfyUI-3D-Pack/raw/a35a737676cf3cbb23360d98032870e242dae199/requirements.txt
https://github.com/kijai/ComfyUI-KJNodes/raw/refs/heads/main/requirements.txt
https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite/raw/refs/heads/main/requirements.txt
https://github.com/ltdrdata/ComfyUI-Impact-Pack/raw/refs/heads/Main/requirements.txt
https://github.com/ltdrdata/ComfyUI-Impact-Subpack/raw/refs/heads/main/requirements.txt
https://github.com/ltdrdata/ComfyUI-Inspire-Pack/raw/refs/heads/main/requirements.txt
https://github.com/WASasquatch/was-node-suite-comfyui/raw/refs/heads/main/requirements.txt
https://github.com/edenartlab/eden_comfy_pipelines/raw/refs/heads/main/requirements.txt
https://github.com/ltdrdata/ComfyUI-Manager/raw/refs/heads/main/requirements.txt
)

for line in "${array[@]}";
    do curl -w "\n" -sSL "${line}" >> requirements5.txt
done

sed -i '/^#/d' requirements5.txt
sed -i 's/[[:space:]]*$//' requirements5.txt
sed -i 's/>=.*$//' requirements5.txt
sed -i 's/_/-/g' requirements5.txt

sort -ufo requirements5.txt requirements5.txt

# Remove duplicate items, compare to requirements4.txt
grep -Fixv -f requirements4.txt requirements5.txt > temp.txt && mv temp.txt requirements5.txt

echo "<requirements5.txt> generated. Check before use."
