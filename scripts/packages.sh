#!/usr/bin/env -S bash
set -x
cd "${BWDIR}" || exit
list_unsorted="$(cat "${BWDIR}"/build-scripts/list)"

echo "$list_unsorted" 


exit




#list_sorted="${list_unsorted//$'\n'/ }"
#list="$(echo "$list_sorted")"
#echo "${list[@]}"
#eval aur sync -cuT --no-view --ignore=python-haishoku "${list}"
