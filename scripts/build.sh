#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
set -x
export BWDIR
export tz
rm -rf "${BWDIR}"/output/ || true
mkdir "${BWDIR}"/output/
mkdir -p "${BWDIR}"/reuse/git || true
pwd
mkdir -p ~/packages/cronlog/"${year}/${month}/${day}/${time}" || true
mkdir -p ~/packages/cronlog/"${year}/${month}/${day}/${time}" || true

date
cd "${BWDIR}"
echo "Packages Start"
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
"${BWDIR}"/build-scripts/scripts/packages.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/packages

date
echo "Nvidia Start"
cd "${BWDIR}"
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/nvidia || true
"${BWDIR}"/build-scripts/scripts/nvidia.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/nvidia
echo "Nvidia Complete"

date
echo "Kernel Start"
"${BWDIR}"/build-scripts/scripts/kernel.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/kernel
echo "Kernel Complete"
eval repo-add ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/timeend || true
date 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/timeend
