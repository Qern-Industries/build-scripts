set -x
rm -rf ${BWDIR}/output/ || true
mkdir output
pwd
echo "Kernel Start"
mkdir -p ${BWDIR}/log/ || true
#${BWDIR}/build-scripts/scripts/kernel.sh
echo "Kernel Complete"
echo "Nvidia Start"
cd ${BWDIR}
touch ${BWDIR}/log/nvidia || true
${BWDIR}/build-scripts/scripts/nvidia.sh >> ${BWDIR}/log/nvidia
echo "Nvidia Complete"
cd ${BWDIR}
cp ${BWDIR}/output/*.pkg.tar.zst ~/packages/
echo "Packages Start"
touch ${BWDIR}/log/packages || true
${BWDIR}/build-scripts/scripts/packages.sh >> ${BWDIR}/log/packages
echo "Think this works."
