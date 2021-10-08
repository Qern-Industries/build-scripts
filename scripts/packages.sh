#!/usr/bin/env -S bash
set -x
cd "${BWDIR}" || exit
while read -r arg; do
    date; time aur sync -uT --no-view --margs --skipinteg "$arg" || true
done < "${BWDIR}/build-scripts/list"
