mkdir -p ${BWDIR}/reuse/git || true
mkdir -p ${BWDIR}/reuse/cfg/nvidia || true
cd ${BWDIR}/reuse/git
git clone https://github.com/Frogging-Family/nvidia-all || true
git fetch --all
git reset --hard origin/master
rm ${BWDIR}/reuse/cfg/nvidia/* || true
cp ${BWDIR}/build-scripts/cfg/nvidia-5.13.cfg ${BWDIR}/reuse/cfg/nvidia/
sed -i "s|_EXT_CONFIG_PATH=~/.config/frogminer/nvidia-all.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/nvidia/nvidia-5.13.cfg|g" ${BWDIR}/reuse/git/nvidia-all/customization.cfg || true
cd ${BWDIR}/reuse/git/nvidia-all
makepkg -s 
cp ${BWDIR}/reuse/git/nvidia-all/*.pkg.tar.zst ${BWDIR}/output/


