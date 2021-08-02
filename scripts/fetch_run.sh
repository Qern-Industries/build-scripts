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
touch ${BWDIR}/log/build || true
${BWDIR}/build-scripts/scripts/build.sh >> ${BWDIR}/log/build
