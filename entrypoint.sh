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


# Custom flags to be used on the fly
# Added by Atila on centos8 branch
# recently put on master by Aristeu

# LocalConfig.txt variables (with iped_ prefix)
for v in \
        iped_locale \
        iped_indexTemp \
        iped_indexTempOnSSD \
        iped_outputOnSSD \
        iped_numThreads \
        iped_kffDb \
        iped_ledWkffPath \
        iped_photoDNAHashDatabase \
        iped_ledDie \
        iped_tskJarPath \
        iped_mplayerPath \
        iped_optional_jars \
        iped_regripperFolder
do
        echo ${v} = ${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" /root/IPED/iped/LocalConfig.txt
        fi
done

# IPEDConfig.txt variables (with iped_ prefix)
for v in \
        iped_hash \
        iped_enablePhotoDNA \
        iped_enableKff \
        iped_enableLedWkff \
        iped_enableLedDie \
        iped_excludeKffIgnorable \
        iped_ignoreDuplicates \
        iped_exportFileProps \
        iped_processFileSignatures \
        iped_enableFileParsing \
        iped_expandContainers \
        iped_enableRegexSearch \
        iped_enableLanguageDetect \
        iped_enableNamedEntityRecogniton \
        iped_enableGraphGeneration \
        iped_indexFileContents \
        iped_indexUnknownFiles \
        iped_indexCorruptedFiles \
        iped_enableOCR \
        iped_enableAudioTranscription \
        iped_addFileSlacks \
        iped_addUnallocated \
        iped_indexUnallocated \
        iped_enableCarving \
        iped_enableKFFCarving \
        iped_enableKnownMetCarving \
        iped_enableImageThumbs \
        iped_enableImageSimilarity \
        iped_enableVideoThumbs \
        iped_enableHTMLReport
do
        echo ${v} = ${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" /root/IPED/iped/profiles/*/*/IPEDConfig.txt
        fi
done

# AdvancedConfig.txt variables (with iped_ prefix)
for v in \
        iped_robustImageReading \
        iped_numImageReaders \
        iped_enableExternalParsing \
        iped_numExternalParsers \
        iped_externalParsingMaxMem \
        iped_phoneParsersToUse \
        iped_forceMerge \
        iped_timeOut \
        iped_timeOutPerMB \
        iped_embutirLibreOffice \
        iped_sortPDFChars \
        iped_entropyTest \
        iped_minRawStringSize \
        iped_extraCharsToIndex \
        iped_convertCharsToLowerCase \
        iped_filterNonLatinChars \
        iped_convertCharsToAscii \
        iped_ignoreHardLinks \
        iped_minOrphanSizeToIgnore \
        iped_unallocatedFragSize \
        iped_minItemSizeToFragment \
        iped_textSplitSize \
        iped_useNIOFSDirectory \
        iped_commitIntervalSeconds \
        iped_OCRLanguage \
        iped_pageSegMode \
        iped_minFileSize2OCR \
        iped_maxFileSize2OCR \
        iped_pdfToImgResolution \
        iped_maxPDFTextSize2OCR \
        iped_pdfToImgLib \
        iped_externalPdfToImgConv \
        iped_externalConvMaxMem \
        iped_processImagesInPDFs \
        iped_searchThreads \
        iped_maxBackups \
        iped_backupInterval \
        iped_autoManageCols \
        iped_preOpenImagesOnSleuth \
        iped_openImagesCacheWarmUpEnabled \
        iped_openImagesCacheWarmUpThreads
do
        echo ${v} = ${!v}
        if [ "${!v}" ]
        then
                sed -i -e "s|.*${v#iped_} =.*|${v#iped_} = ${!v}|" /root/IPED/iped/profiles/*/*/conf/AdvancedConfig.txt
        fi
done


# no arguments = bash, otherwise exec then
exec "$@"
