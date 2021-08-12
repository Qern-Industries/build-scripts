mkdir -p ${BWDIR}/reuse/git || true
mkdir -p ${BWDIR}/reuse/cfg/nvidia || true
cd ${BWDIR}/reuse/git
git clone https://github.com/Frogging-Family/nvidia-all || true
sed "s|\${BWDIR}/reuse/cfg/nvidia/nvidia-5.13.cfg|\~/.config/frogminer/linux-tkg.cfg|g" ${BWDIR}/reuse/git/nvidia-all/customization.cfg || true
git pull origin || true
rm ${BWDIR}/reuse/cfg/nvidia/* || true
cp ${BWDIR}/build-scripts/cfg/nvidia-5.13.cfg ${BWDIR}/reuse/cfg/nvidia/
sed "s|\~/.config/frogminer/nvidia-all.cfg|${BWDIR}/reuse/nvidia/nvidia-5.13.cfg|g" ${BWDIR}/reuse/git/nvidia-a;;/customization.cfg || true
cd ${BWDIR}/reuse/git/nvidia-all
makepkg -s 
cp ${BWDIR}/reuse/git/nvidia-all/*.pkg.tar.zst ${BWDIR}/output/


