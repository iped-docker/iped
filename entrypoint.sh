#!/bin/bash
set -e
PHOTODNA=false
HASHESDB=false
COUNTRY='BR'



echo -n Populating IPED plugins directory with extra plugins...
if [ -d /mnt/plugins ] && [ ! -z "$(ls /mnt/plugins)" ]
then
        cd /root/IPED/plugins/ && find /mnt/plugins -type f \
                | xargs -I% sh -c 'ln -s "$@" > /dev/null 2>&1 && echo -n $@[OK]...|| echo -n $@[FAILED]...' _ %
                echo "Done."
fi

if [ ! -z "$(ls /root/IPED/plugins/ | grep -i photodna | grep -i '\.jar$' )" ]
then
        PHOTODNA=true

        echo -n Setting PhotoDNA related flags to $PHOTODNA... && \
        sed -i -e "s/enablePhotoDNA =.*/enablePhotoDNA = $PHOTODNA/" /root/IPED/iped/IPEDConfig.txt && \
        sed -i -e "s/enablePhotoDNALookup =.*/enablePhotoDNALookup = $PHOTODNA/" /root/IPED/iped/IPEDConfig.txt && \
        echo Done. || echo Failed.
fi


if [ -f /mnt/hashesdb/iped-hashes.db ]
then
        HASHESDB=true         

        echo -n Setting HASHDB related flags to $HASHESDB... && \
        sed -i -e "s/enableHashDBLookup =.*/enableHashDBLookup = $HASHESDB/" /root/IPED/iped/IPEDConfig.txt && \
        sed -i -e "s/enableLedCarving =.*/enableLedCarving = $HASHESDB/" /root/IPED/iped/IPEDConfig.txt && \
        echo Done. || echo Failed.

        # check if HASHESDBONTMP is setted, if it is, copy it to tmp dir
        # can be used in cases that hashesdb in on the network and the only way
        # to accelerate things is to put it on tmpdir, that is mandatory to be local
        if [ "$HASHESDBONTMP" == "true" ] 
        then
                echo -n "Copying iped-hashes.db to /mnt/ipedtmp..." && \
                cp -p --update /mnt/hashesdb/iped-hashes.db /mnt/ipedtmp/ && echo -n OK... && \
                echo -n "Updating config..." && \
                sed -i -e "s/hashesDB =.*/hashesDB = \/mnt\/ipedtmp\/iped-hashes.db/" /root/IPED/iped/LocalConfig.txt && \
                echo OK. || -n echo Failed.

        fi

fi


# Custom flags to be used to modify configuration on runtime
# LocalConfig.txt variables (with iped_ prefix)
for v in \
        iped_locale \
        iped_indexTemp \
        iped_indexTempOnSSD \
        iped_outputOnSSD \
        iped_numThreads \
        iped_hashesDB \
        iped_tskJarPath \
        iped_mplayerPath \
        iped_pluginFolder \
        iped_regripperFolder
do
        echo ${v}=${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" /root/IPED/iped/LocalConfig.txt
        fi
done

# IPEDConfig.txt variables (with iped_ prefix)
for v in \
        iped_enableHash \
        iped_enablePhotoDNA \
        iped_enableHashDBLookup \
        iped_enablePhotoDNALookup \
        iped_enableLedDie \
        iped_enableYahooNSFWDetection \
        iped_enableQRCode \
        iped_ignoreDuplicates \
        iped_exportFileProps \
        iped_processFileSignatures \
        iped_enableFileParsing \
        iped_expandContainers \
        iped_processEmbeddedDisks \
        iped_enableRegexSearch \
        iped_enableAutomaticExportFiles \
        iped_enableLanguageDetect \
        iped_enableNamedEntityRecogniton \
        iped_enableGraphGeneration \
        iped_entropyTest \
        iped_enableSplitLargeBinary \
        iped_indexFileContents \
        iped_enableIndexToElasticSearch \
        iped_enableMinIO \
        iped_enableAudioTranscription \
        iped_enableCarving \
        iped_enableLedCarving \
        iped_enableKnownMetCarving \
        iped_enableImageThumbs \
        iped_enableImageSimilarity \
        iped_enableFaceRecognition \
        iped_enableVideoThumbs \
        iped_enableDocThumbs \
        iped_enableHTMLReport 
do
        echo ${v}=${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" /root/IPED/iped/IPEDConfig.txt
        fi
done

# IPED variables setting on the config dir (with iped_ prefix)
for v in $( for file in $( find /root/IPED/iped/conf/ -type f | grep Config.txt \
            | grep -v -i regex); do grep -v "#" $file | grep -v "\." | grep -v "^host =" \
            | grep -v "^port = " | cut -d "=" -f 1 | sort -u \
            | awk '{ if ($0 != "\r" ) {print "iped_"$0;} }';\
            done )        
do
        echo ${v}=${!v}
        if [ "${!v}" ]
        then
                find /root/IPED/iped/conf/ -type f | grep Config.txt | grep -v -i regex | xargs sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" 
        fi
done

echo Setting GraphConfig...
for v in \
        iped_phone_region
do
        echo ${v}=${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*\"$(echo ${v#iped_}| sed 's/_/-/g')\":.*|\"$(echo ${v#iped_}| sed 's/_/-/g')\":\"${!v}\",|" /root/IPED/iped/conf/GraphConfig.json 
        else 
                sed -i -e "s|.*\"$(echo ${v#iped_}| sed 's/_/-/g')\":.*|\"$(echo ${v#iped_}| sed 's/_/-/g')\":\"${COUNTRY}\",|" /root/IPED/iped/conf/GraphConfig.json
        fi

done



# no arguments = bash, otherwise exec then
exec "$@"
