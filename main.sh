#!/usr/bin/bash

set -x

cd ..
BWDIR=$(pwd)
export BWDIR
bash "${BWDIR}"/build-scripts/reuse/export-essential.sh

while IFS= read -r _qi_build_arg; do
    export ${_qi_build_arg}
    if [[ $(cat "${BWDIR}/build-scripts/switches/${_qi_act_script}" > /dev/null; echo $?) = 1 ]]; then
       echo "Switch for ${_qi_act_script} not found, not running."
    elif [[ $(cat "${BWDIR}/build-scripts/switches/${_qi_act_script}" > /dev/null; echo $?) = 0 ]]; then
         if [[ $(cat "${BWDIR}/build-scripts/switches/${_qi_act_script}") = 0 ]]; then
              echo "Switch for ${_qi_act_script} disabled, not running."
         elif [[ $(cat "${BWDIR}/build-scripts/switches/${_qi_act_script}") = 1 ]]; then 
              echo "Switch for ${_qi_act_script} enabled, running."
               "${BWDIR}"/build-scripts/reuse/pre-template.sh
         else
              echo "Unexpected condition, exiting."
              exit
         fi
    else
       echo "Unexpected condition, exiting." 
    fi
done < "${BWDIR}/build-scripts/script-list"

ccache -sv

touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend || true
date 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend
