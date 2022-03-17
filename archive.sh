#!/bin/bash
cd ~/ || exit
lrztar -L 9 -z ~/packages/ 
_qi_build_year=$(TZ=US/New_York date +"%Y")
_qi_build_month=$(TZ=US/New_York date +"%m")
_qi_build_day=$(TZ=US/New_York date +"%d")
_qi_build_time=$(TZ=US/New_York date +"%H-%M-%S")
mkdir -p ~/archive/ || true
mv packages.tar.lrz ~/archive/$(TZ=US/New_York date +"%Y-%m-%d--%H-%M-%S").tar.lrz
