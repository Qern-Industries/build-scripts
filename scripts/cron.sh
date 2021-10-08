#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
#0 5 * * * cd /home/eile/build/build-scripts/scripts/ && ./cron.sh
#crondate=$(date +"%d-%m-%Y-%H-%M-%S")
year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
time=$(date +"%H-%M-%S")
export year
export month
export day
export time
mkdir -p ~/packages/cronlog/ || true
./fetch_run.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/cronlog
