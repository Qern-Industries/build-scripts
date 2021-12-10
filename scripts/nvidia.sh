#!/usr/bin/bash
mkdir -p "${BWDIR}"/reuse/git || true
mkdir -p "${BWDIR}"/reuse/cfg/nvidia || true
cd "${BWDIR}"/reuse/git || exit
git clone https://github.com/Frogging-Family/nvidia-all || true
cd "${BWDIR}"/reuse/git/nvidia-all || exit
git fetch --all
git reset --hard origin/master
rm "${BWDIR}"/reuse/cfg/nvidia/* || true
cp "${BWDIR}"/build-scripts/cfg/nvidia.cfg "${BWDIR}"/reuse/cfg/nvidia/
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/nvidia-all.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/nvidia/nvidia.cfg|g" "${BWDIR}"/reuse/git/nvidia-all/customization.cfg || true
cd "${BWDIR}"/reuse/git/nvidia-all || exit
makepkg -sfCc --sign || true
cp "${BWDIR}"/reuse/git/nvidia-all/*.pkg.tar.zst ~/packages/
cp "${BWDIR}"/reuse/git/nvidia-all/*.pkg.tar.zst.sig ~/packages/

