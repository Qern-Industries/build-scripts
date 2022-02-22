#!/usr/bin/bash

cd ..
BWDIR=$(pwd)

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

bash "${BWDIR}"/build-scripts/reuse/export-essential.sh
export BWDIR

while IFS= read -r _qi_build_arg; do
    export ${_qi_build_arg}
    if [[ "${_qi_act_switch}" = 0 ]]; then
          echo "Switch for $_qi_act_fancy disabled, not running."
    else
          echo "Switch for $_qi_act_fancy enabled, running."
          "${BWDIR}"/build-scripts/reuse/pre-template.sh
    fi
done < "${BWDIR}/build-scripts/script-list"

ccache -sv

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend || true
date 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend


    if [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 1 ]]; then
       :
    elif [[ $(cat "${BWDIR}/build-scripts/debug" > /dev/null; echo $?) = 0 ]]; then
         if [[ $(cat "${BWDIR}/build-scripts/debug") = 0 ]]; then
                cd ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}"/
                lrztar -L 9 -z ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
                cd "${BWDIR}" || exit
                rm -rf ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
         elif [[ $(cat "${BWDIR}/build-scripts/debug") = 1 ]]; then 
              echo "Debug enabled, not compressing logs."
         else
              echo "Unexpected condition, exiting."
              exit
         fi
    else
       echo "Unexpected condition, exiting." 
    fi                

