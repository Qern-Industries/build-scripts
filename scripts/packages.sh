#!/usr/bin/bash
set -x
cd "${BWDIR}" || exit
list_unsorted="$(cat "${BWDIR}"/build-scripts/list)"
list_sorted="${list_unsorted//$'\n'/ }"
list=("${list_sorted}")
echo "${list[@]}"
aur sync -uT --no-view --ignore=python-haishoku "${list[@]}"
