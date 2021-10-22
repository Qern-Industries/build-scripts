#!/usr/bin/env -S bash
set -x
mkdir -p "${BWDIR}/build"
cd "${BWDIR}/build" || exit
while read -r arg; do
    mkdir -p ~/packages/git/ || true
    cd ~/packages/git/ || true
    date; time aur fetch -r --sync=reset $arg || true
done < "${BWDIR}/build-scripts/list"
while read -r arg; do
    cd ~/packages/git/$"{arg}"
    date; time aur build --no-sync --margs -n,-s,--clean $arg || true
done < "${BWDIR}/build-scripts/list"
cd "${BWDIR}"
