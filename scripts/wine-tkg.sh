#!/usr/bin/bash
set -x
cd "${BWDIR}" || exit

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/desktop-6700k || true
touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/laptop-4700u || true

mkdir -p "${BWDIR}"/reuse/git || true
mkdir -p "${BWDIR}"/reuse/cfg/wine-tkg-git || true

cd "${BWDIR}"/reuse/git || exit
git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
    git fetch --all || exit
    git reset --hard origin/master || exit

sudo pacman -S --noconfirm --needed schedtool || true
cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
git fetch --all
git reset --hard origin/master

rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
cp "${BWDIR}"/reuse/cfg/wine-tkg-git/wine.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg

git fetch --all
git reset --hard origin/master
cd "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/ || exit
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/reuse/cfg/wine-tkg-git/wine-advanced-6700k.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/desktop-6700k || exit

git fetch --all
git reset --hard origin/master
cd "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/ || exit
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/reuse/cfg/wine-tkg-git/wine-advanced-4700u.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/laptop-4700u || exit

cd "${BWDIR}" || exit

cp "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/*.pkg.tar.zst ~/packages/

