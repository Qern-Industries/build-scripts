#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
set -x
export BWDIR
export date
export repo
export repolocation
export tz
rm -rf "${BWDIR}"/output/ || true
mkdir "${BWDIR}"/output/
mkdir -p "${BWDIR}"/reuse/git || true
pwd
mkdir -p "${repolocation}"/log/"${date}" || true
rm -rf "${repolocation}"/log/* || true
mkdir -p "${repolocation}"/log/"${date}" || true

date
cd "${BWDIR}"
echo "Packages Start"
touch "${repolocation}"/log/"${date}"/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
"${BWDIR}"/build-scripts/scripts/packages.sh 2>&1 | tee -a "${repolocation}"/log/"${date}"/packages

date
echo "Nvidia Start"
cd "${BWDIR}"
touch "${repolocation}"/log/"${date}"/nvidia || true
"${BWDIR}"/build-scripts/scripts/nvidia.sh 2>&1 | tee -a "${repolocation}"/log/"${date}"/nvidia
echo "Nvidia Complete"

date
echo "Kernel Start"
"${BWDIR}"/build-scripts/scripts/kernel.sh 2>&1 | tee -a "${repolocation}"/log/"${date}"/kernel
echo "Kernel Complete"
eval repo-add "${repolocation}"/"${repo}".db.tar.gz "${repolocation}"/*.pkg.tar.zst

touch "${repolocation}"/log/"${date}"/timeend || true
date 2>&1 | tee -a "${repolocation}"/log/"${date}"/timeend
