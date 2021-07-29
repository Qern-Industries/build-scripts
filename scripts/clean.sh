set -x
echo clean.sh start
        export GIT_TRACE_PACKET=1
        export GIT_TRACE=1
        export GIT_CURL_VERBOSE=1
        #sudo apt update
        git config --global core.compression 0
        #sudo apt install git default-jre -y
        java -version
        git clone --mirror https://github.com/Osmium-Linux/osmium-pkgs.git
        cd osmium-pkgs.git
        wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
        java -jar bfg-*.jar --strip-blobs-bigger-than 1M
        git reflog expire --expire=now --all && git gc --prune=now --aggressive
        rm bfg-*.jar
        git config user.email "tysayahi@gmail.com"
        git config user.name "Eile Kerning"
        #git remote set-url origin https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
        git config --unset remote.origin.mirror
        git config --unset remote.origin.mirror
        cd ..
        rm -rf osmium-pkgs.git
echo clean.sh stop