set -x
date
pwd
echo "Update Start"
    cd ..
    git pull origin master
echo "Update Complete"
cd ..
BWDIR="$(pwd)"
echo ${BWDIR}
export BWDIR
rm -rf ${BWDIR}/output/ || true
mkdir output
pwd
echo "Kernel Start"
mkdir -p ${BWDIR}/log/ || true
touch ${BWDIR}/log/6700k || true
touch ${BWDIR}/log/4700u || true
chmod +x ${BWDIR}/build-scripts/scripts/kernel-6700k.sh || true
${BWDIR}/build-scripts/scripts/kernel-6700k.sh >> ${BWDIR}/log/6700k
chmod +x ${BWDIR}/build-scripts/scripts/kernel-4700u.sh || true
${BWDIR}/build-scripts/scripts/kernel-4700u.sh >> ${BWDIR}/log/4700u
echo "Kernel Complete"
