
#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit
#0 5 * * * cd /home/eile/build/build-scripts/scripts/ && ./cron.sh
#crondate=$(date +"%d-%m-%Y-%H-%M-%S")
cronyear=$(date +"%Y")
cronmonth=$(date +"%m")
cronday=$(date +"%d")
crontime=$(date +"%H-%M-%S")
mkdir -p ~/packages/cronlog/ || true
./fetch_run.sh 2>&1 | tee -a ~/packages/cronlog/"${cronyear}/${cronmonth}/${cronday}/${crontime}"
