#!/usr/bin/bash

_qi_build_year=$(TZ=US/New_York date +"%Y")
_qi_build_month=$(TZ=US/New_York date +"%m")
_qi_build_day=$(TZ=US/New_York date +"%d")
_qi_build_time=$(TZ=US/New_York date +"%H-%M-%S")

export _qi_build_{day,month,year,time}

echo "Update Start"
    git fetch --all || exit
    git reset --hard origin/master || exit
echo "Update Complete"

mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/ || exit
touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/log || true

./main.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/main || exit
