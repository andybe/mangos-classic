#!/bin/bash
DAEMON=mangosd

cd /app/bin
screen -dmS classic-mangos ./$DAEMON detached
echo "MaNGOS daemon started"

export TEST=2
#mangos server still up?
while [ $TEST -gt 1 ] ;
do
     sleep 1;
     export TEST="$(ps uax | grep $DAEMON  | wc -l)";
done