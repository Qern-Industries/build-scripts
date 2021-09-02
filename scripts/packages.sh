set -x
cd "${BWDIR}" || exit
list_unsorted="$(cat "${BWDIR}"/build-scripts/list)"
list="${list_unsorted//$'\n'/ }"
echo "$list"
aur sync -uT --no-view --ignore=python-haishoku "$list"
