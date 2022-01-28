#!/usr/bin/bash
set -x
cd "${BWDIR}" || exit
rm -rf "${BWDIR}"/reuse/git/linux-tkg/*.pkg.tar.zst
mkdir -p touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/linux-tkg
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/linux-tkg/desktop-6700k || true
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/linux-tkg/laptop-4700u || true
mkdir -p "${BWDIR}"/reuse/git || true
mkdir -p "${BWDIR}"/reuse/cfg/kernel || true
cd "${BWDIR}"/reuse/git || exit
git clone https://github.com/Frogging-Family/linux-tkg || true
cd "${BWDIR}"/reuse/git/linux-tkg || exit
git pull origin || true
rm "${BWDIR}"/reuse/cfg/kernel/* || true
cp "${BWDIR}"/build-scripts/cfg/linux-tkg/laptop-4700u.cfg "${BWDIR}"/reuse/cfg/kernel/
cp "${BWDIR}"/build-scripts/cfg/linux-tkg/desktop-6700k.cfg "${BWDIR}"/reuse/cfg/kernel/

sudo pacman -S --noconfirm --needed schedtool || true
cd "${BWDIR}"/reuse/git/linux-tkg || exit
git fetch --all
git reset --hard origin/master
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/desktop-6700k.cfg|g" "${BWDIR}"/reuse/git/linux-tkg/customization.cfg || true
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/linux-tkg/desktop-6700k || exit

cd "${BWDIR}"/reuse/git/linux-tkg || exit
git fetch --all
git reset --hard origin/master
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/laptop-4700u.cfg|g" "${BWDIR}"/reuse/git/linux-tkg/customization.cfg || true
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/linux-tkg/laptop-4700u || exit

cd "${BWDIR}" || exit
pwd
cp "${BWDIR}"/reuse/git/linux-tkg/*.pkg.tar.zst ~/packages/

