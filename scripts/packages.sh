#!/usr/bin/env -S bash
set -x
cd "${BWDIR}" || exit
list_unsorted="$(cat "${BWDIR}"/build-scripts/list)"
list_sorted="${list_unsorted//$'\n'/ }"
list="(echo "$list_sorted")"
echo "${list[@]}"
aur sync -uT --no-view --ignore=python-haishoku "${list}"
