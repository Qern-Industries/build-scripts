#!/usr/bin/bash

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

echo "${_qi_act_fancy} Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/"
time "${BWDIR}"/build-scripts/scripts/${_qi_act_script}.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/${_qi_act_script}" || exit
echo "${_qi_act_fancy} Complete"

if [[ "${_qi_act_script}" = qern-packages ]]; then
  echo "$_qern_act_fancy} detected. Not repo-adding."
else
  eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst
fi
