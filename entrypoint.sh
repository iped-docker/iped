#!/bin/bash
set -e
PHOTODNA=false
LED=false
KFF=false
PROJECTVIC=false

if [ -d /mnt/PhotoDNA ] && [ ! -z "$(ls /mnt/PhotoDNA)" ] && [ ! -z "$(ls /root/IPED/optional_jars/ | grep photodna)" ] 
then
        PHOTODNA=true
fi

if [ -d /mnt/led ] && [ ! -z "$(ls /mnt/led)" ]
then
        LED=true
fi

if [ -d /mnt/kff ] && [ ! -z "$(ls /mnt/kff)" ]
then
        KFF=true
fi

if [ -d /mnt/ProjectVic ] && [ ! -z "$(ls /mnt/ProjectVic)" ]
then
        PROJECTVIC=true
fi


#
# Note: Changes in the root IPEDConfig.txt are avoided in the new IPED Version
# when the locale variable is defined.
# 
# Setting PhotoDNA related flags
# sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/profiles/*/pedo*/IPEDConfig.txt

# Setting LED related flags
# sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/profiles/*/pedo*/IPEDConfig.txt

# sed -i -e "s/enableLedWkff =.*/enableLedWkff = $LED/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedWkff =.*/enableLedWkff = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enableLedWkff =.*/enableLedWkff = $LED/" /root/IPED/iped/profiles/*/pedo*/IPEDConfig.txt
sed -i -e "s/enableKFFCarving =.*/enableKFFCarving = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enableKFFCarving =.*/enableKFFCarving = $LED/" /root/IPED/iped/profiles/*/pedo*/IPEDConfig.txt

# Setting KFF related flags
# sed -i -e "s/enableKff =.*/enableKff = $KFF/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableKff =.*/enableKff = $KFF/" /root/IPED/iped/profiles/*/*/IPEDConfig.txt

#ProjectVic Settings
sed -i -e "s/enableProjectVicHashLookup =.*/enableProjectVicHashLookup = $PROJECTVIC/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enableProjectVicHashLookup =.*/enableProjectVicHashLookup = $PROJECTVIC/" /root/IPED/iped/profiles/*/pedo*/IPEDConfig.txt

# no arguments = bash, otherwise exec then
exec "$@"
