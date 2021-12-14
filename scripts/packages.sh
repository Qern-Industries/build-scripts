#!/usr/bin/env -S bash
set -x
bash ~/cache-gpg.sh
date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r "$(cat ${BWDIR}/build-scripts/list)" || true
