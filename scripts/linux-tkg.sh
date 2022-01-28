#!/usr/bin/bash
set -x
cd "${BWDIR}" || exit

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/desktop-6700k || true
touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/laptop-4700u || true

mkdir -p "${BWDIR}"/reuse/git || true
mkdir -p "${BWDIR}"/reuse/cfg/linux-tkg || true

cd "${BWDIR}"/reuse/git || exit
git clone https://github.com/Frogging-Family/linux-tkg || true
cd "${BWDIR}"/reuse/git/linux-tkg || exit
    git fetch --all || exit
    git reset --hard origin/master || exit

rm "${BWDIR}"/reuse/cfg/linux-tkg/* || true
cp "${BWDIR}"/build-scripts/cfg/linux-tkg/laptop-4700u.cfg "${BWDIR}"/reuse/cfg/linux-tkg/
cp "${BWDIR}"/build-scripts/cfg/linux-tkg/desktop-6700k.cfg "${BWDIR}"/reuse/cfg/linux-tkg/

sudo pacman -S --noconfirm --needed schedtool || true
cd "${BWDIR}"/reuse/git/linux-tkg || exit
git fetch --all
git reset --hard origin/master
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/linux-tkg/desktop-6700k.cfg|g" "${BWDIR}"/reuse/git/linux-tkg/customization.cfg || true
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/desktop-6700k || exit

cd "${BWDIR}"/reuse/git/linux-tkg || exit
git fetch --all
git reset --hard origin/master
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/linux-tkg/laptop-4700u.cfg|g" "${BWDIR}"/reuse/git/linux-tkg/customization.cfg || true
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/laptop-4700u || exit

cd "${BWDIR}" || exit

cp "${BWDIR}"/reuse/git/linux-tkg/*.pkg.tar.zst ~/packages/

