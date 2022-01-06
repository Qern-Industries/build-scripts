#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
#0 5 * * * cd /home/eile/build/build-scripts/scripts/ ; ./fetch.sh
#crondate=$(date +"%d-%m-%Y-%H-%M-%S")

set -x
year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
time=$(date +"%H-%M-%S")
export year
export month
export day
export time

cd ..
cd ..
BWDIR=$(pwd)
echo "${BWDIR}"
export BWDIR

mkdir -p ~/packages/cronlog/"${year}/${month}/${day}/${time}" || true
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/build
"${BWDIR}"/build-scripts/scripts/build.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/build
