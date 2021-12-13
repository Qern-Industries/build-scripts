#!/usr/bin/env -S bash
set -x
bash ~/cache-gpg.sh
date; time echo $(cat ~/passphrase) | aur sync -uTf --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r --sign "$(cat ${BWDIR}/build-scripts/list)" || true
