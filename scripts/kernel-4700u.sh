set -x
rm -rf work || true
mkdir work
cd work
pwd
git clone --depth 1 https://github.com/Frogging-Family/linux-tkg
rm ./linux-tkg/customization.cfg
cd ..
cp ./build-scripts/kernel/cfg/zenbook-14-4700u.cfg ./work/linux-tkg/customization.cfg
cd ./work/linux-tkg/
pwd
makepkg -s 
cd ..
cd ..
pwd
cp ./work/linux-tkg/*.pkg.tar.zst ./output/
