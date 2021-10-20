#!/usr/bin/env -S bash
set -x
cd "${BWDIR}" || exit
while read -r arg; do
    date; time base_packages=('base-devel' 'multilib-devel' 'gcc-git') aur sync -uT --no-view --margs --noconfirm $arg || true
done < "${BWDIR}/build-scripts/list"
