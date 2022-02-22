#!/usr/bin/env -S bash
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf
    if [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 1 ]]; then
       :
    elif [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 0 ]]; then
         if [[ $(cat "${BWDIR}/build-scripts/debug") = 0 ]]; then
              :
         elif [[ $(cat "${BWDIR}/build-scripts/debug") = 1 ]]; then 
              echo "Debug enabled, setting -x."
              set -x
         else
              echo "Unexpected condition, exiting."
              exit
         fi
    else
       echo "Unexpected condition, exiting." 
    fi     
date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r "$(cat ${BWDIR}/build-scripts/lists/*/*)" || exit
