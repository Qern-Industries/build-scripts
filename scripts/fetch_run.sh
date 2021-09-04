#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
set -x
pwd
echo "Update Start"
    cd ..
    git fetch --all
    git reset --hard origin/master
echo "Update Complete"
cd ..
BWDIR=$(pwd)
tz=$(cat "${BWDIR}"/build-scripts/timezone)
repolocation=$(cat "${BWDIR}"/build-scripts/repolocation)
repo=$(cat "${BWDIR}"/build-scripts/repo)
date=$(TZ="${tz}" date +"%d-%m-%Y-%H-%M-%S")
echo "${BWDIR}"
mkdir -p "${BWDIR}"/log/"${date}"/ || true
touch "${BWDIR}"/log/"${date}"/build || true
export BWDIR
export date
export repo
export repolocation
export tz
"${BWDIR}"/build-scripts/scripts/build.sh 2>&1 | tee -a "${BWDIR}"/log/"${date}"/build
