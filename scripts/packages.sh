cd ${BWDIR}
list_unsorted="$(cat ${BWDIR}/build-scripts/list)"
list="${list_unsorted//$'\n'/ }"
echo $list