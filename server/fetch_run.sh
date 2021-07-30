set -x
date
pwd
echo "Update Start"
    cd ..
    git pull origin master
echo "Update Complete"
cd ..
rm -rf ./output/ || true
mkdir output
pwd
#echo "Export Variables"
#    export GIT_TRACE_PACKET=1
#    export GIT_TRACE=1
#    export GIT_CURL_VERBOSE=1
#echo "clean.sh start"
#    chmod +x ./build-scripts/scripts/clean.sh
#    time bash ./build-scripts/scripts/clean.sh
echo "Kernel Start"
chmod +x ./build-scripts/scripts/kernel-6700k.sh || true
./build-scripts/scripts/kernel-6700k.sh >> ./log/6700k
chmod +x ./build-scripts/scripts/kernel-4700u.sh || true
./build-scripts/scripts/kernel-4700u.sh >> ./log/4700u
