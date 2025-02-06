#!/bin/bash
# You need to install <Git for Windows> with <Git Bash> (installed by default)
# https://git-scm.com/download/win

set -eu

# If you don't want a FORCE update, remove "git reset" line
function git_pull () {
    git_remote_url=$(git -C "$1" remote get-url origin) ;

    if [[ $git_remote_url =~ ^(https:\/\/github\.com\/)(.*)(\.git)$ ]]; then
        echo "Updating: $1" ;
        git -C "$1" reset --hard ;
        git -C "$1" pull --ff-only ;
        echo "Done Updating: $1" ;
    fi ;
}

git_pull ComfyUI

cd ./ComfyUI/custom_nodes
for D in *; do
    if [ -d "${D}" ] && [ "${D}" != "ComfyUI-3D-Pack" ]; then
        git_pull "${D}" &
    fi
done

wait $(jobs -p)

exit 0
