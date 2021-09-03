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
mkdir -p "${BWDIR}"/log/"${date}" || true
rm -rf "${repolocation}"/log/* || true
mkdir -p "${repolocation}"/log/"${date}" || true

date
cd "${BWDIR}"
cp "${BWDIR}"/output/*.pkg.tar.zst ~/packages/
echo "Packages Start"
touch "${BWDIR}"/log/"${date}"/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
"${BWDIR}"/build-scripts/scripts/packages.sh 2>&1 | tee -a "${BWDIR}"/log/"${date}"/packages
cp -r "${BWDIR}/log/"${date}"/* "${repolocation}"/log/

date
echo "Nvidia Start"
cd "${BWDIR}"
touch "${BWDIR}"/log/"${date}"/nvidia || true
"${BWDIR}"/build-scripts/scripts/nvidia.sh 2>&1 | tee -a "${BWDIR}"/log/"${date}"/nvidia
echo "Nvidia Complete"
cp -r "${BWDIR}/log/"${date}"/* "${repolocation}"/log/

date
echo "Kernel Start"
"${BWDIR}"/build-scripts/scripts/kernel.sh 2>&1 | tee -a "${BWDIR}"/log/"${date}"/kernel
echo "Kernel Complete"
repo-add "${repolocation}"/"${repo}".db.tar.gz "${repolocation}"/*.pkg.tar.zst
cp -r "${BWDIR}/log/"${date}"/* "${repolocation}"/log/

touch "${BWDIR}"/log/"${date}"/timeend || true
date 2>&1 | tee -a "${BWDIR}"/log/"${date}"/timeend
