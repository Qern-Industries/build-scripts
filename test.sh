set -e
set -x
      cd ..
     BWDIR=$(pwd)

     while IFS= read -r _qi_linux_arg; do
     export ${_qi_linux_arg}
     echo ${_qi_linux_arg}
     done < "${BWDIR}/build-scripts/linux-targets"
