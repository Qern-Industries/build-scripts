#!/usr/bin/env -S bash
set -x
date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r,--skippgpcheck "$(cat ${BWDIR}/build-scripts/list)" || exit
