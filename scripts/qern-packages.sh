#!/usr/bin/env -S bash
#Packages may fail to build unless keyserver-options auto-key-retrieve is in ~/.gnupg/gpg.conf

#date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r "$(cat ${BWDIR}/build-scripts/lists/*/*)" || exit
