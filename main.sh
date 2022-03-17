#!/usr/bin/bash
main () {
     # Set Base working dir.
     cd ..
     BWDIR=$(pwd)

     # Check if debug is enabled; if so, set -x

     if cat "${BWDIR}/build-scripts/debug"; then
          if [[ $(cat "${BWDIR}/build-scripts/debug") = 0 ]]; then
               :
          else
               echo "Debug enabled, setting -x."
               set -x
          fi
     else
          :
     fi     

     export BWDIR


     while IFS= read -r _qi_build_arg; do
     export ${_qi_build_arg}
     if [[ "${_qi_act_switch}" = 0 ]]; then
               echo "Switch for $_qi_act_fancy disabled, not running."
     else
               echo "Switch for $_qi_act_fancy enabled, running."
               pre-script
     fi
     done < "${BWDIR}/build-scripts/script-list"

     ccache -sv

     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend || true
     date 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/timeend



     # Check if debug is enabled; if so, don't compress logs.

     if cat "${BWDIR}/build-scripts/debug"; then
                    if [[ $(cat "${BWDIR}/build-scripts/debug") = 0 ]]; then
                         cd ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}"/
                         lrztar -L 9 -z ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
                         cd "${BWDIR}" || exit
                         rm -rf ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/
                    elif [[ $(cat "${BWDIR}/build-scripts/debug") = 1 ]]; then 
                         echo "Debug enabled, not compressing logs."
                    else
                         echo "Unexpected condition, exiting."
                         exit
                    fi
     else
          :
     fi                

}

pre-script () {
     echo "${_qi_act_fancy} Start"
     cd "${BWDIR}"
     mkdir -p ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/"
     time ${_qi_act_script} 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/${_qi_act_script}/${_qi_act_script}" || exit
     echo "${_qi_act_fancy} Complete"

     if [[ "${_qi_act_script}" = qern-packages ]]; then
     echo "$_qern_act_fancy} detected. Not repo-adding."
     else
     eval repo-add -n ~/packages/qern-packs.db.tar.gz ~/packages/*.pkg.tar.zst
     fi
}



linux-tkg () {
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/{desktop-{skylake,zen2},laptop-zen2} || true
     mkdir -p "${BWDIR}"/reuse/{git,cfg/linux-tkg} || true
     cd "${BWDIR}"/reuse/git || exit
     git clone https://github.com/Frogging-Family/linux-tkg || true
     cd "${BWDIR}"/reuse/git/linux-tkg || exit
     git fetch --all || exit
     git reset --hard origin/master || exit
     rm "${BWDIR}"/reuse/cfg/linux-tkg/* || true
     cp "${BWDIR}"/build-scripts/cfg/linux-tkg/*.cfg "${BWDIR}"/reuse/cfg/linux-tkg/
     sudo pacman -S --noconfirm --needed schedtool || true
     
     _qi_lintkg_target=desktop-skylake
     linux-tkg-pkgbuild
     _qi_lintkg_target=desktop-zen2
     linux-tkg-pkgbuild
     _qi_lintkg_target=laptop-zen2
     linux-tkg-pkgbuild
     
     cd "${BWDIR}" || exit
     mv "${BWDIR}"/reuse/git/linux-tkg/*.pkg.tar.zst ~/packages/
}

linux-tkg-pkgbuild () {
     cd "${BWDIR}"/reuse/git/linux-tkg || exit
     git fetch --all
     git reset --hard origin/master
     sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/linux-tkg/${_qi_lintkg_target}.cfg|g" "${BWDIR}"/reuse/git/linux-tkg/customization.cfg || true
     makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}"/linux-tkg/${_qi_lintkg_target} || exit
}

qern-packages () {
     date; time aur sync -uT --no-view --margs --asdeps,--needed,--noconfirm,--noprogressbar,-C,-c,-s,-r "$(cat ${BWDIR}/build-scripts/lists/*/*)" || exit
}

nvidia-tkg () {
     mkdir -p "${BWDIR}"/reuse/{git,cfg/nvidia} || true
     cd "${BWDIR}"/reuse/git || exit
     git clone https://github.com/Frogging-Family/nvidia-all || true
     cd "${BWDIR}"/reuse/git/nvidia-all || exit
     git fetch --all
     git reset --hard origin/master
     rm "${BWDIR}"/reuse/cfg/nvidia/* || true
     cp "${BWDIR}"/build-scripts/cfg/nvidia-tkg/nvidia.cfg "${BWDIR}"/reuse/cfg/nvidia/
     sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/nvidia-all.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/nvidia/nvidia.cfg|g" "${BWDIR}"/reuse/git/nvidia-all/customization.cfg || true
     cd "${BWDIR}"/reuse/git/nvidia-all || exit
     makepkg -sfCc --noconfirm || exit
     cp "${BWDIR}"/reuse/git/nvidia-all/*.pkg.tar.zst ~/packages/
}

proton-tkg () {
     while IFS= read -r _qi_wine_arg; do
     export ${_qi_wine_arg}
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/proton-tkg/${_qi_target_nice}"
     rm -rf "${BWDIR}"/reuse/cfg/proton-tkg/ || true
     mkdir -p "${BWDIR}"/reuse/{git,/cfg/proton-tkg} || true
     cd "${BWDIR}"/reuse/git || exit
     git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
     cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
     git fetch --all || exit
     git reset --hard origin/master || exit
     sudo pacman -S --noconfirm --needed schedtool || true
     rm -rf "${BWDIR}/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/{advanced-,}customization.cfg"
     cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/wine-tkg/wine-advanced.cfg" > "${BWDIR}/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg"
     rm -rf "${BWDIR}/reuse/git/wine-tkg-git/wine-tkg-git/proton-tkg/proton-tkg-profiles/{advanced-customization,proton-tkg}.cfg"
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/proton-tkg/proton-advanced.cfg" > "${BWDIR}/reuse/git/wine-tkg-git/proton-tkg/proton-tkg-profiles/advanced-customization.cfg"
     cp "${BWDIR}"/build-scripts/cfg/proton-tkg/proton.cfg "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/proton-tkg.cfg
     cd "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/ || exit
     eval sed -i 's/pkgname=proton-tkg-git/pkgname=proton-tkg-${_qi_target_nice}-qern/g' PKGBUILD
     makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/wine-tkg/${_qi_target_nice}" || exit
     mv "${BWDIR}"/reuse/git/wine-tkg-git/proton-tkg/*.pkg.tar.zst ~/packages/ || true
     done < "${BWDIR}/build-scripts/wine-targets"
}

wine-tkg () {
     while IFS= read -r _qi_wine_arg; do
     export ${_qi_wine_arg}
     touch ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/wine-tkg/${_qi_target_nice}"
     rm -rf "${BWDIR}"/reuse/cfg/wine-tkg/ || true
     mkdir -p "${BWDIR}"/reuse/{git,/cfg/wine-tkg} || true
     cd "${BWDIR}"/reuse/git || exit
     git clone https://github.com/Frogging-Family/wine-tkg-git/ || true
     cd "${BWDIR}"/reuse/git/wine-tkg-git || exit
     git fetch --all || exit
     git reset --hard origin/master || exit
     sudo pacman -S --noconfirm --needed schedtool || true
     rm -rf "${BWDIR}/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/{advanced-,}customization.cfg"
     cp "${BWDIR}"/build-scripts/cfg/wine-tkg/wine.cfg "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/customization.cfg
     eval sed 's/GCCTUNE/${_qi_target_gcc}/g' "${BWDIR}/build-scripts/cfg/wine-tkg/wine-advanced.cfg" > "${BWDIR}/reuse/git/wine-tkg-git/wine-tkg-git/wine-tkg-profiles/advanced-customization.cfg"
     cd "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/ || exit
     makepkg -sfCc --noconfirm 2>&1 | tee -a ~/packages/cronlog/"${_qi_build_year}/${_qi_build_month}/${_qi_build_day}/${_qi_build_time}/wine-tkg/${_qi_target_nice}" || exit
     mv "${BWDIR}"/reuse/git/wine-tkg-git/wine-tkg-git/*.pkg.tar.zst ~/packages/ || true
     done < "${BWDIR}/build-scripts/wine-targets"
}



main "$@"; exit

