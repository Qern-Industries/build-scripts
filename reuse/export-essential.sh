#!/usr/bin/bash

    if [[ $(cat "${BWDIR}/build-scripts/switches/debug" > /dev/null; echo $?) = 1 ]]; then
       :
    elif [[ $(cat "${BWDIR}/build-scripts/switches/debug" > /dev/null; echo $?) = 0 ]]; then
         if [[ $(cat "${BWDIR}/build-scripts/switches/debug") = 0 ]]; then
              :
         elif [[ $(cat "${BWDIR}/build-scripts/switches/debug") = 1 ]]; then 
              echo "Debug enabled, setting -x."
              set -x
         else
              echo "Unexpected condition, exiting."
              exit
         fi
    else
       echo "Unexpected condition, exiting." 
    fi     

export BWDIR _qi_build_{day,month,year,time}
