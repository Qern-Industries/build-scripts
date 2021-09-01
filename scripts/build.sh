set -x
export BWDIR
export date
export repo
export repolocation
export tz
rm -rf ${BWDIR}/output/ || true
mkdir ${BWDIR}/output/
mkdir -p ${BWDIR}/reuse/git || true
pwd
mkdir -p ${BWDIR}/log/${date} || true

date
echo "Nvidia Start"
cd ${BWDIR}
touch ${BWDIR}/log/${date}/nvidia || true
${BWDIR}/build-scripts/scripts/nvidia.sh 2>&1 | tee -a ${BWDIR}/log/${date}/nvidia
echo "Nvidia Complete"

date
cd ${BWDIR}
cp ${BWDIR}/output/*.pkg.tar.zst ~/packages/
echo "Packages Start"
touch ${BWDIR}/log/${date}/packages || true
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
${BWDIR}/build-scripts/scripts/packages.sh 2>&1 | tee -a ${BWDIR}/log/${date}/packages

date
echo "Kernel Start"
${BWDIR}/build-scripts/scripts/kernel.sh 2>&1 | tee -a ${BWDIR}/log/${date}/kernel
echo "Kernel Complete"
repo-add ${repolocation}/${repo}.db.tar.gz ${repolocation}/*.pkg.tar.xz

touch ${BWDIR}/log/${date}/timeend || true
date 2>&1 | tee -a ${BWDIR}/log/${date}/timeend
