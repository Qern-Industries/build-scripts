set -x
date
touch ${BWDIR}/log/timestart || true
date 2>&1 | tee -a ${BWDIR}/log/timestart
pwd
echo "Update Start"
    cd ..
    git fetch --all
    git reset --hard origin/master
echo "Update Complete"
cd ..
BWDIR="$(pwd)"
echo ${BWDIR}
export BWDIR
touch ${BWDIR}/log/build || true
${BWDIR}/build-scripts/scripts/build.sh 2>&1 | tee -a ${BWDIR}/log/build
