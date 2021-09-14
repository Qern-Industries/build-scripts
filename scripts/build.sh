#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
set -x
export BWDIR
export date
export tz
rm -rf "${BWDIR}"/output/ || true
mkdir "${BWDIR}"/output/
mkdir -p "${BWDIR}"/reuse/git || true
pwd
mkdir -p ~/packages/log/"${date}" || true
rm -rf ~/packages/log/* || true
mkdir -p ~/packages/log/"${date}" || true

date
cd "${BWDIR}"
echo "Packages Start"
touch ~/packages/log/"${date}"/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
"${BWDIR}"/build-scripts/scripts/packages.sh 2>&1 | tee -a ~/packages/log/"${date}"/packages

date
echo "Nvidia Start"
cd "${BWDIR}"
touch ~/packages/log/"${date}"/nvidia || true
"${BWDIR}"/build-scripts/scripts/nvidia.sh 2>&1 | tee -a ~/packages/log/"${date}"/nvidia
echo "Nvidia Complete"

date
echo "Kernel Start"
"${BWDIR}"/build-scripts/scripts/kernel.sh 2>&1 | tee -a ~/packages/log/"${date}"/kernel
echo "Kernel Complete"
eval repo-add ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst

touch ~/packages/log/"${date}"/timeend || true
date 2>&1 | tee -a ~/packages/log/"${date}"/timeend
