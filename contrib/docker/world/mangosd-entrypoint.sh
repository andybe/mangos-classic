#!/bin/bash
DAEMON=mangosd
LOGS=/app/logs

# while stage the realm & mangos world server at the
# same time uuid/guid for the mangos user is equal

chown -R mangos:mangos $LOGS/*
chown -R mangos:mangos /app/bin/$DAEMON

cd /app/bin

# run daemon as mangos user
su -s /bin/bash -c "screen -dmS classic-mangos ./$DAEMON detached" mangos

echo "MaNGOS daemon started"

export TEST=2
#mangos server still up?
while [ $TEST -gt 1 ] ;
do
     sleep 1;
     export TEST="$(ps uax | grep $DAEMON  | wc -l)";
done
