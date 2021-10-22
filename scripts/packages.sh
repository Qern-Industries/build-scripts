#!/usr/bin/env -S bash
set -x
date; time aur sync -uT --no-view --margs -n,-s,--clean "$(cat ${BWDIR}/build-scripts/list)" || true
