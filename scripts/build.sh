set -x
rm -rf ${BWDIR}/output/ || true
mkdir output
pwd
echo "Kernel Start"
mkdir -p ${BWDIR}/log/ || true
touch ${BWDIR}/log/6700k || true
touch ${BWDIR}/log/4700u || true
#chmod +x ${BWDIR}/build-scripts/scripts/kernel-6700k.sh || true
#${BWDIR}/build-scripts/scripts/kernel-6700k.sh >> ${BWDIR}/log/6700k
#chmod +x ${BWDIR}/build-scripts/scripts/kernel-4700u.sh || true
#${BWDIR}/build-scripts/scripts/kernel-4700u.sh >> ${BWDIR}/log/4700u
echo "Kernel Complete"
echo "Nvidia Start"
cd ${BWDIR}
#chmod +x ${BWDIR}/build-scripts/scripts/nvidia.sh || true
touch ${BWDIR}/log/nvidia || true
${BWDIR}/build-scripts/scripts/nvidia.sh >> ${BWDIR}/log/nvidia
echo "Nvidia Complete"
cd ${BWDIR}
cp ${BWDIR}/output/*.pkg.tar.zst ~/packages/
echo "Packages Start"
touch ${BWDIR}/log/packages || true
#chmod +x ${BWDIR}/build-scripts/scripts/packages.sh || true
${BWDIR}/build-scripts/scripts/packages.sh >> ${BWDIR}/log/packages
echo "Think this works."
