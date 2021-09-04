#!/usr/bin/env -S bash
set -x
cd "${BWDIR}" || exit
while read arg; do
    aur sync -cuT --no-view "$arg" || true
done < ""${BWDIR}"/build-scripts/list"
