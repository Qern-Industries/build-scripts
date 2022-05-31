      cd ..
     BWDIR=$(pwd)
set -e
set -x
     while IFS= read -r _qi_linux_arg; do
     export ${_qi_linux_arg}
     echo ${_qi_linux_arg}
     done < "${BWDIR}/build-scripts/linux-targets"
