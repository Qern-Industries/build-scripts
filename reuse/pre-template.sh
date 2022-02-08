#!/usr/bin/bash

echo "${_qi_act_fancy} Start"
cd "${BWDIR}"
mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/"
time "${BWDIR}"/build-scripts/scripts/${_qi_act_script}.sh 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/${_qi_act_script}" || exit
echo "${_qi_act_fancy} Complete"
eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst
