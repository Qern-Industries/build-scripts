set -x
cd ${BWDIR}
touch ${BWDIR}/log/6700k || true
touch ${BWDIR}/log/4700u || true
mkdir -p ${BWDIR}/reuse/git || true
mkdir -p ${BWDIR}/reuse/cfg/kernel || true
cd ${BWDIR}/reuse/git
git clone https://github.com/Frogging-Family/linux-tkg || true
sed "s|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/desktop-6700k.cfg|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|g" ${BWDIR}/reuse/git/linux-tkg/customization.cfg || true
sed "s|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/zenbook-14-4700u.cfg|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|g" ${BWDIR}/reuse/git/linux-tkg/customization.cfg || true
git pull origin || true
rm ${BWDIR}/reuse/cfg/kernel/* || true
cp ${BWDIR}/build-scripts/cfg/zenbook-14-4700u.cfg ${BWDIR}/reuse/cfg/kernel/
cp ${BWDIR}/build-scripts/cfg/desktop-6700k.cfg ${BWDIR}/reuse/cfg/kernel/
sed "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/desktop-6700k.cfg|g" ${BWDIR}/reuse/git/linux-tkg/customization.cfg || true
cd ${BWDIR}/reuse/git/linux-tkg
makepkg -s 
sed "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/zenbook-14-4700u.cfg|g" ${BWDIR}/reuse/git/linux-tkg/customization.cfg || true
git pull origin || true
sed "s|_EXT_CONFIG_PATH=~/.config/frogminer/linux-tkg.cfg|_EXT_CONFIG_PATH=${BWDIR}/reuse/cfg/kernel/zenbook-14-4700u.cfg|g" ${BWDIR}/reuse/git/linux-tkg/customization.cfg || true
cd ${BWDIR}/reuse/git/linux-tkg
makepkg -s 
cd ${BWDIR}
pwd
cp ${BWDIR}/reuse/git/linux-tkg/*.pkg.tar.zst ${BWDIR}/output/
    
