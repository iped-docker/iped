#!/bin/bash
PHOTODNA=false
LED=false
KFF=false
if [ -z "$(ls /mnt/PhotoDNA)" ]
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

sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt

sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedDie =.*/enableLedDie = $LED/" /root/ILED/iped/profiles/*/default/IPEDConfig.txt

sed -i -e "s/enableLedWkff =.*/enableLedWkff = $KFF/" /root/IPED/iped/IPEDConfig.txt
sed -i -e "s/enableLedWkff =.*/enableLedWkff = $KFF/" /root/IPED/iped/profiles/*/default/IPEDConfig.txt

exec "$@"
