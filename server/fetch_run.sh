set -x
date
pwd
echo "Update Start"
    cd ..
    git pull origin master
echo "Update Complete"
cd ..
pwd
#echo "Export Variables"
#    export GIT_TRACE_PACKET=1
#    export GIT_TRACE=1
#    export GIT_CURL_VERBOSE=1
#echo "clean.sh start"
#    chmod +x ./build-scripts/scripts/clean.sh
#    time bash ./build-scripts/scripts/clean.sh
echo "Kernel Start"