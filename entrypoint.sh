#!/bin/bash
PHOTODNA=false
LED=false
KFF=false
if [ -z "$(ls /mnt/PhotoDNA)" ] && [ -z "$(ls /root/IPED/optional_jars/photodna-*.jar)" ] 
then
        PHOTODNA=true
fi

if [ -z "$(ls /mnt/led)" ]
then
        LED=true
fi

if [ -z "$(ls /mnt/kff)" ]
then
        KFF=true
fi

#
# Note: Changes in the root IPEDConfig.txt are avoided in the new IPED Version
# when the locale variable is defined.
# 
# Setting PhotoDNA related flags
# sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt

# Setting LED related flags
# sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
# sed -i -e "s/enableLedWkff =.*/enableLedWkff = $LED/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedWkff =.*/enableLedWkff = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt
sed -i -e "s/enableKFFCarving =.*/enableKFFCarving = $LED/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt

# Setting KFF related flags
# sed -i -e "s/enableKff =.*/enableKff = $KFF/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableKff =.*/enableKff = $KFF/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt


exec "$@"
