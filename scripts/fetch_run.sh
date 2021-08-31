set -x
date
tz="$cat ${BWDIR}/build-scripts/timezone"
date="$(TZ="${tz}" date +"%d-%m-%Y-%S-%M-%H")"
touch ${BWDIR}/log/${date}/timestart || true
date 2>&1 | tee -a ${BWDIR}/log/${date}/timestart
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
mkdir -p ${BWDIR}/log/${date}/ || true
touch ${BWDIR}/log/${date}/build || true
${BWDIR}/build-scripts/scripts/build.sh 2>&1 | tee -a ${BWDIR}/log/${date}/build
