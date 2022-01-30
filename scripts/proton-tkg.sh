#!/usr/bin/bash
set -x
cd "${BWDIR}" || exit

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/desktop-6700k || true
touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/laptop-4700u || true

mkdir -p "${BWDIR}"/reuse/git || true
mkdir -p "${BWDIR}"/reuse/cfg/proton-tkg || true

cd "${BWDIR}"/reuse/git || exit
git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
    git fetch --all || exit
    git reset --hard origin/master || exit

sudo pacman -S --noconfirm --needed schedtool || true
cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
git fetch --all
git reset --hard origin/master

git fetch --all
git reset --hard origin/master
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg.cfg
cp "${BWDIR}"/build-scripts/cfg/proton-tkg/proton.cfg "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg.cfg
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/build-scripts/cfg/proton-tkg/proton-advanced-6700k.cfg "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg 
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/desktop-6700k || exit

git fetch --all
git reset --hard origin/master
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg.cfg
cp "${BWDIR}"/reuse/cfg/proton-tkg/proton.cfg "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg.cfg
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/build-scripts/cfg/proton-tkg/proton-advanced-4700u.cfg "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg 
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/laptop-4700u || exit

cd "${BWDIR}" || exit

cp "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/*.pkg.tar.zst ~/packages/

