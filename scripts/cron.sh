#0 5 * * * cd /home/eile/build/build-scripts/scripts/ && ./cron.sh
crondate=$(TZ="${tz}" date +"%d-%m-%Y-%H-%M-%S")
mkdir -p ~/packages/cronlog/ || true
./fetch_run.sh 2>&1 | tee -a ~/packages/cronlog/"${crondate}"
