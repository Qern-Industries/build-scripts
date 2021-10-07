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
date=$(TZ="${tz}" date +"%d-%m-%Y-%H-%M-%S")
echo "${BWDIR}"
mkdir -p ~/packages/cronlog/"${year}/${month}/${day}/${time}"/ || true
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/build || true
export BWDIR
export date
export tz
"${BWDIR}"/build-scripts/scripts/build.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/build
