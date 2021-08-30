set -x
date
rm -rf ${BWDIR}/output/ || true
mkdir ${BWDIR}/output/
mkdir -p cd ${BWDIR}/reuse/git || true
pwd
mkdir -p ${BWDIR}/log/ || true

date
echo "Nvidia Start"
cd ${BWDIR}
touch ${BWDIR}/log/nvidia || true
${BWDIR}/build-scripts/scripts/nvidia.sh 2>&1 | tee -a ${BWDIR}/log/nvidia
echo "Nvidia Complete"

date
cd ${BWDIR}
cp ${BWDIR}/output/*.pkg.tar.zst ~/packages/
echo "Packages Start"
touch ${BWDIR}/log/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
${BWDIR}/build-scripts/scripts/packages.sh 2>&1 | tee -a ${BWDIR}/log/packages

date
echo "Kernel Start"
${BWDIR}/build-scripts/scripts/kernel.sh 2>&1 | tee -a ${BWDIR}/log/kernel
echo "Kernel Complete"

echo "Think this works."
date
