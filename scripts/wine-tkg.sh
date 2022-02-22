#!/usr/bin/bash
    if [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 1 ]]; then
       :
    elif [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 0 ]]; then
         if [[ $(cat "${BWDIR}/build-scripts/debug") = 0 ]]; then
              :
         elif [[ $(cat "${BWDIR}/build-scripts/debug") = 1 ]]; then 
              echo "Debug enabled, setting -x."
              set -x
         else
              echo "Unexpected condition, exiting."
              exit
         fi
    else
       echo "Unexpected condition, exiting." 
    fi     
cd "${BWDIR}" || exit

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg/skylake || true
touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg/zen2 || true

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

_NOINITIALPROMPT="true"
export _NOINITIALPROMPT
touch "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/BIG_UGLY_FROGMINER

git fetch --all
git reset --hard origin/master
cd "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/ || exit
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine-advanced-skylake.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
touch "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/BIG_UGLY_FROGMINER
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg/skylake || exit

git fetch --all
git reset --hard origin/master
cd "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/ || exit
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine-advanced-zen2.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg 
rm -rf "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
touch "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/BIG_UGLY_FROGMINER
makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg/zen2 || exit

cd "${BWDIR}" || exit

cp "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/*.pkg.tar.zst ~/packages/

