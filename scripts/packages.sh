set -x
cd ${BWDIR}
rm -rf ${BWDIR}/work || true
mkdir ${BWDIR}/work
cd ${BWDIR}/work
list_unsorted="$(cat ${BWDIR}/build-scripts/list)"
list="${list_unsorted//$'\n'/ }"
echo $list
aur sync -cuT --no-view $list
