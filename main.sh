#!/usr/bin/bash
main () {
     # Set base directory
     cd ..
     BWDIR=$(pwd)

     mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"

     set -e

     # Check if debug is enabled, and if so, set -x
     if [[  -f "${BWDIR}/build-scripts/debug" ]]; then
          echo "Debug enabled, setting -x."
          set -x
     fi

     export BWDIR

     while IFS='' read -r _qi_build_arg || [ "$_qi_build_arg"]; do
          export ${_qi_build_arg}
          cd "${BWDIR}"
          if [[ "${_qi_act_switch}" = 1 ]]; then
               echo "Switch for $_qi_act_fancy enabled, running."
               pre-script
          else
               echo "Switch for $_qi_act_fancy disabled, not running."
          fi
     done < "${BWDIR}/build-scripts/script-list"

     ccache -sv 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/ccache
     date 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend
     if [[ ! -f "${BWDIR}/build-scripts/debug" ]]; then
          cd ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}"/ || exit
          lrztar -L 9 -z ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
          cd "${BWDIR}" || exit
          rm -rf ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
     fi
     exit
}

pre-script () {
     clean
     rm -rf "${BWDIR}"/work/ || true
     mkdir -p touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/"
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/${_qi_act_script}" 
     time ${_qi_act_script} 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/${_qi_act_script}" 
     echo "${_qi_act_fancy} Complete"
     if [[ "${_qi_act_script}" = qern-packages ]]; then
          echo "$_qern_act_fancy} detected. Not repo-adding."
     else
          rm -rf ~/packages/qern-packs.*
          eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst
          :
     fi
}

linux-tkg () {
     while IFS='' read -r _qi_linux_arg || [ "$_qi_linux_arg"] || true; do
          clean
          export ${_qi_linux_arg}
          if [[ "${_qi_act_switch}" = 1 ]]; then
               echo "Switch for $_qi_lintkg_target enabled, running."
               linux-tkg-build
          else
               echo "Switch for $_qi_lintkg_target disabled, not running."
          fi
     done < "${BWDIR}/build-scripts/linux-targets"
}

linux-tkg-build () {
     rm -rf "${BWDIR}"/work/ || true
     mkdir -p "${BWDIR}/work/"
     cd "${BWDIR}/work/"
     git clone https://github.com/Frogging-Family/linux-tkg || true
     cd "${BWDIR}/work/linux-tkg"
     sudo pacman -Syu --noconfirm --needed schedtool || true
     sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/build-scripts/cfg/linux-tkg/${_qi_lintkg_target}.cfg|g" "${BWDIR}"/work/linux-tkg/customization.cfg || true
     mkdir -p touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/"
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/${_qi_lintkg_target}
     makepkg -s --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/${_qi_lintkg_target} || exit
     mv "${BWDIR}"/work/linux-tkg/*.pkg.tar.zst ~/packages/
     rm -rf "${BWDIR}"/work/ || true
}

qern-packages () {
     clean
     sudo pacman -Syu --noconfirm
     date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r "$(cat ${BWDIR}/build-scripts/lists/*/*)" || exit
}

nvidia-tkg () {
     clean
     mkdir -p "${BWDIR}/work/"
     cd "${BWDIR}/work/"
     git clone https://github.com/Frogging-Family/nvidia-all
     cd "${BWDIR}"/work/nvidia-all || exit
     sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/nvidia-all.cfg|_EXT_CONFIG_PATH=${BWDIR}/build-scripts/cfg/nvidia-tkg/nvidia.cfg|g" "${BWDIR}"/work/nvidia-all/customization.cfg || true
     makepkg -s --noconfirm
     mv "${BWDIR}"/work/nvidia-all/*.pkg.tar.zst ~/packages/
}

proton-tkg () {
     while IFS='' read -r _qi_proton_arg || [ "$_qi_proton_arg"]; do
     clean
     export ${_qi_wine_arg}
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/proton-tkg/${_qi_target_nice}"
     rm -rf "${BWDIR}"/work/ || true
     mkdir -p "${BWDIR}/work/"
     cd "${BWDIR}/work/"
     git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
     cd "${BWDIR}/work/wine-tkg-git/proton-tkg/"
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/wine-tkg/wine-advanced.cfg" > "${BWDIR}/work/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg"
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/proton-tkg/proton-advanced.cfg" > "${BWDIR}/work/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg"
     cp "${BWDIR}"/build-scripts/cfg/proton-tkg/proton.cfg "${BWDIR}"/work/wine-tkg-git/proton-tkg/proton-tkg.cfg
     eval sed -i 's/pkgname=proton-tkg-git/pkgname=proton-tkg-${_qi_target_nice}-qern/g' PKGBUILD
     makepkg -s --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/proton-tkg/${_qi_target_nice}" || exit
     mv "${BWDIR}"/work/wine-tkg-git/proton-tkg/*.pkg.tar.zst ~/packages/ || true
     done < "${BWDIR}/build-scripts/wine-targets"
}

wine-tkg () {
     while IFS='' read -r _qi_wine_arg || [ "$_qi_wine_arg"]; do
     clean
     export ${_qi_wine_arg}
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/wine-tkg/${_qi_target_nice}"
     rm -rf "${BWDIR}"/work/ || true
     mkdir -p "${BWDIR}/work/"
     cd "${BWDIR}/work/"
     git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
     cd "${BWDIR}/work/wine-tkg-git/wine-tkg-git"
     cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine.cfg "${BWDIR}"/work/wine-tkg-git/wine-tkg-git/customization.cfg
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/wine-tkg/wine-advanced.cfg" > "${BWDIR}/work/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg"
     makepkg -s --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/wine-tkg/${_qi_target_nice}" || exit
     mv "${BWDIR}"/work/wine-tkg-git/wine-tkg-git/*.pkg.tar.zst ~/packages/ || true
     done < "${BWDIR}/build-scripts/wine-targets"
}

clean () {
     sudo rm -rf /tmp/*
}

main; exit
