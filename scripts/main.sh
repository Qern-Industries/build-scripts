#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf

set -x

cd ../..
BWDIR=$(pwd)
export BWDIR

echo "Packages Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/qern-packages/
time "${BWDIR}"/build-scripts/scripts/qern-packages.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/qern-packages/qern-packages
echo "Packages Complete"

echo "Nvidia Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/nvidia-tkg/
#time "${BWDIR}"/build-scripts/scripts/nvidia-tkg.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/nvidia-tkg/nvidia-tkg
echo "Nvidia Complete"
#eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

echo "Kernel Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/
#time "${BWDIR}"/build-scripts/scripts/linux-tkg.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/linux-tkg
echo "Kernel Complete"
#eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

echo "Wine Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/
#time "${BWDIR}"/build-scripts/scripts/wine-tkg.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/wine-tkg-git/wine-tkg-git
echo "Wine Complete"
#eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

echo "Proton Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/
#time "${BWDIR}"/build-scripts/scripts/proton-tkg.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/proton-tkg/proton-tkg
echo "Proton Complete"
#eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

ccache -sv

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend || true
date 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend
