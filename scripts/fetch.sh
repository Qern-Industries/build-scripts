#!/usr/bin/bash
set -x

year=$(date +"%Y")
month=$(date +"%m")
day=$(date +"%d")
time=$(date +"%H-%M-%S")
date=$(TZ=US/New_York date +"%d-%m-%Y-%H-%M-%S")

pwd
echo "Update Start"
    git fetch --all || exit
    git reset --hard origin/master || exit
echo "Update Complete"

mkdir -p ~/packages/cronlog/"${year}/${month}/${day}/${time}"/ || true
touch ~/packages/cronlog/"${year}/${month}/${day}/${time}"/log || true

./run.sh 2>&1 | tee -a ~/packages/cronlog/"${year}/${month}/${day}/${time}"/log || exit
