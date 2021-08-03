set -x
touch ${BWDIR}/log/6700k || true
touch ${BWDIR}/log/4700u || true
mkdir -p ${BWDIR}/reuse/git || true
mkdir -p ${BWDIR}/reuse/cfg/kernel || true
cd ${BWDIR}/reuse/git
git clone https://github.com/Frogging-Family/linux-tkg || true
sed "s|\${BWDIR}/reuse/desktop-6700k.cfg|\~/.config/frogminer/linux-tkg.cfg|g" ${BWDIR}/reuse/linux-tkg/customization.cfg
git pull origin || true
rm ${BWDIR}/reuse/cfg/kernel/*
cp ${BWDIR}/build-scripts/cfg/zenbook-14-4700u.cfg ${BWDIR}/reuse/cfg/kernel/
cp ${BWDIR}/build-scripts/cfg/desktop-6700k.cfg ${BWDIR}/reuse/cfg/kernel/
sed "s|\~/.config/frogminer/linux-tkg.cfg|${BWDIR}/reuse/desktop-6700k.cfg|g" ${BWDIR}/reuse/linux-tkg/customization.cfg
cd ${BWDIR}
rm -rf ${BWDIR}/work || true
mkdir ${BWDIR}/work
cd ${BWDIR}/work
pwd
git clone --depth 1 https://github.com/Frogging-Family/linux-tkg
rm ./linux-tkg/customization.cfg
cd ${BWDIR}
cp ${BWDIR}/build-scripts/cfg/zenbook-14-4700u.cfg ${BWDIR}/work/linux-tkg/customization.cfg
cd ${BWDIR}/work/linux-tkg/
pwd
makepkg -s 
cd ${BWDIR}
pwd
cp ${BWDIR}/work/linux-tkg/*.pkg.tar.zst ${BWDIR}/output/
rm -rf ${BWDIR}/work || true
