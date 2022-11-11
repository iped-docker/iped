# IPED Container

![CI](https://github.com/iped-docker/iped/workflows/CI/CD/badge.svg)


Install Docker version 19.03.5 and above if you want to use GPU's.

### Before you begin, fast tips for rapid deployment
##### FAST TIP Num.1: If you just want to use the latest docker (without building or customizing it), go directly to "Adjusting the environment for execution" section and follow the instructions until the end of the page.
##### FAST TIP Num.2: If you just want to process the evidences with latest docker (again, without building or customizing it), in text mode and without analysis interface on linux (graphical analysis of the resulting case can be made afterwards in another computer for example, running Windows or Linux), use the following command:

```
sudo docker run --rm -it -v /mnt/evidences:/evidences \
                 -v /mnt/ipedtmp:/mnt/ipedtmp \
                 -v /mnt/plugins:/mnt/plugins \
                 -v /mnt/hashdb:/mnt/hashdb \
                   ipeddocker/iped:processor java -jar iped.jar --nogui \
                 -d /evidences/test/test.dd \
                 -o /evidences/test/iped-output 
```

It can be used without the optional features also. We recommend that at least the evidences and temporary folder be used as volumes:
```
sudo docker run --rm -it -v /mnt/evidences:/evidences \ 
                 -v /mnt/ipedtmp:/mnt/ipedtmp \
                 ipeddocker/iped:processor java -jar iped.jar --nogui \
                 -d /evidences/test/test.dd \
                 -o /evidences/test/iped-output
```
Of course, in both cases you'll have to change the volumes to reflect your environment.

##### FAST TIP Num.3: Help can be achieved with the command:
```
sudo docker run --rm -it ipeddocker/iped:processor java -jar iped.jar --help
```
##### FAST TIP Num.4: About the container "flavors"

       - ipeddocker/iped - Full processing and analysis capable environment (larger container)

       - ipeddocker/iped:processor - Environment optimized for evidence processing (smaller container)



#### So, lets begin...


## Docker Image Build 
1. Clone the repository
 
    ```
    git clone https://github.com/iped-docker/iped
    cd iped
    ```
    
2. (Optional) Download optional IPED dependencies:
    The default config files are configured to use these directories inside the docker:
    
    - Plugins: /mnt/plugins    
    - HASHDB: /mnt/hashdb 
    
    If these directories are empty, the entrypoint.sh will disable these features.

    Note: You don't need to change it, it is completely optional, but if you want to change default values for the internal container directories, you can adjust LocalConfig.txt and IPEDConfig.txt to your environment before building it. You just have to take care when configuring the docker volumes. 

3.  Build the IPED docker images: 
    ```
    docker build . -f Dockerfile-processor -t ipeddocker/iped:processor
    docker build . -t ipeddocker/iped
    ```
 
## Adjusting the environment for execution

To use the IPED java program on a graphical interface, it's imperative to configure the docker environment to use a X server. We created a script (the script dkr.source) to easily deploy/execute IPED on X graphical local enviroments.

The script in dkr.source creates a bash function "dkr" that extends the docker command, setting some usefull docker options.

What is inside dkr.source:

    ```
    #!/bin/bash
    dkr () 
    {
      xhost +
      docker run --rm -it -v "`pwd`":"`pwd`":Z \
              -e DISPLAY -e GDK_BACKEND \
              -e GDK_SCALE \
              -e SAL_USE_VCLPLUGIN=gen \
              -e GDK_DPI_SCALE \
              -e QT_DEVICE_PIXEL_RATIO \
              -e LANG=C.UTF-8 \
              -e LC_ALL=C.UTF-8 \
              -e NO_AT_BRIDGE=1 \
              --device /dev/dri \
              --device /dev/snd \
              -v /etc/localtime:/etc/localtime:ro \
              -v /tmp/.X11-unix/:/tmp/.X11-unix/ "$@"
    }
    export -f dkr
    ```

To use it:

```
source dkr.source
dkr ipeddocker/iped
```
## Executing the containers

It's strongly recommended to use the source directories of /mnt/ipedtmp and /mnt/hashesdb volumes on SSD disks!!!

### IPED docker (Processing)

```
    sudo dkr -v /mnt/evidences:/evidences \
                   -v /mnt/ipedtmp:/mnt/ipedtmp \
                   -v /mnt/plugins:/mnt/plugins \            
                   -v /mnt/hashdb:/mnt/hashdb \
                   ipeddocker/iped java -jar iped.jar \
                   -d /evidences/test/test.dd \
                   -o /evidences/test/iped-output
```
### IPED docker (Analysing)
```
    sudo dkr -v /mnt/evidences:/evidences \
           -v /mnt/ipedtmp:/mnt/ipedtmp \
           ipeddocker/iped java -jar \ 
           /evidences/test/iped-output/indexador/lib/iped-search-app.jar 
```

## NEW FEATURE
### Runtime configuration adjustment can be done setting an environment variable with iped_ prefix following the variable name. The variables bellow are currently supported. 
```
iped_locale=
iped_indexTemp=
iped_indexTempOnSSD=
iped_outputOnSSD=
iped_numThreads=
iped_hashesDB=
iped_tskJarPath=
iped_mplayerPath=
iped_pluginFolder=
iped_regripperFolder=
iped_enableHash=
iped_enablePhotoDNA=
iped_enableHashDBLookup=
iped_enablePhotoDNALookup=
iped_enableLedDie=
iped_enableYahooNSFWDetection=
iped_enableQRCode=
iped_ignoreDuplicates=
iped_exportFileProps=
iped_processFileSignatures=
iped_enableFileParsing=
iped_expandContainers=
iped_processEmbeddedDisks=
iped_enableRegexSearch=
iped_enableAutomaticExportFiles=
iped_enableLanguageDetect=
iped_enableNamedEntityRecogniton=
iped_enableGraphGeneration=
iped_entropyTest=
iped_enableSplitLargeBinary=
iped_indexFileContents=
iped_enableIndexToElasticSearch=
iped_enableMinIO=
iped_enableAudioTranscription=
iped_enableCarving=
iped_enableLedCarving=
iped_enableKnownMetCarving=
iped_enableImageThumbs=
iped_enableImageSimilarity=
iped_enableFaceRecognition=
iped_enableVideoThumbs=
iped_enableDocThumbs=
iped_enableHTMLReport=
iped_convertCommand=
iped_language=
iped_maxConcurrentRequests=
iped_mimesToProcess=
iped_requestIntervalMillis=
iped_serviceRegion=
iped_timeout=
iped_connect_timeout_millis=
iped_max_async_requests=
iped_min_bulk_items=
iped_min_bulk_size=
iped_protocol=
iped_timeout_millis=
iped_useCustomAnalyzer=
iped_validateSSL=
iped_hashes=
iped_retries=
iped_timeOut=
iped_updateRefsToMinIO=
iped_zipFilesMaxSize=
iped_enableExternalConv=
iped_externalConversionTool=
iped_extractThumb=
iped_galleryThreads=
iped_highResDensity=
iped_imgConvTimeout=
iped_imgConvTimeoutPerMB=
iped_imgThumbSize=
iped_logGalleryRendering=
iped_lowResDensity=
iped_maxMPixelsInMemory=
iped_excludeKnown=
iped_supportedMimes=
iped_supportedMimesWithLinks=
iped_autoManageCols=
iped_backupInterval=
iped_embedLibreOffice=
iped_maxBackups=
iped_openImagesCacheWarmUpEnabled=
iped_openImagesCacheWarmUpThreads=
iped_openWithDoubleClick=
iped_preOpenImagesOnSleuth=
iped_searchThreads=
iped_maxSimilarityDistance=
iped_searchRotatedAndFlipped=
iped_statusHashDBFilter=
iped_EnableCategoriesList=
iped_EnableImageThumbs=
iped_EnableThumbsGallery=
iped_EnableVideoThumbs=
iped_Examiner=
iped_FramesPerStripe=
iped_Header=
iped_Investigation=
iped_ItemsPerPage=
iped_Material=
iped_Record=
iped_RecordDate=
iped_Report=
iped_ReportDate=
iped_RequestDate=
iped_RequestDoc=
iped_Requester=
iped_ThumbSize=
iped_ThumbsPerPage=
iped_Title=
iped_VideoStripeWidth=
iped_faceDetectionModel=
iped_maxResolution=
iped_upSampling=
iped_commitIntervalSeconds=
iped_convertCharsToAscii=
iped_convertCharsToLowerCase=
iped_extraCharsToIndex=
iped_filterNonLatinChars=
iped_forceMerge=
iped_indexUnallocated=
iped_maxTokenLength=
iped_storeTermVectors=
iped_textSplitSize=
iped_useNIOFSDirectory=
iped_GalleryThumbs=
iped_Layout=
iped_Timeouts=
iped_Verbose=
iped_enableVideoThumbsOriginalDimension=
iped_enableVideoThumbsSubitems=
iped_maxDimensionSize=
iped_categoriesToIgnore=
iped_mimeTypesToIgnore=
iped_OCRLanguage=
iped_enableOCR=
iped_externalConvMaxMem=
iped_externalPdfToImgConv=
iped_maxConvImageSize=
iped_maxFileSize2OCR=
iped_maxPDFTextSize2OCR=
iped_minFileSize2OCR=
iped_pageSegMode=
iped_pdfToImgLib=
iped_pdfToImgResolution=
iped_processNonStandard=
iped_addFileSlacks=
iped_addUnallocated=
iped_ignoreHardLinks=
iped_minOrphanSizeToIgnore=
iped_numImageReaders=
iped_robustImageReading=
iped_skipFolderRegex=
iped_unallocatedFragSize=
iped_fragmentOverlapSize=
iped_itemFragmentSize=
iped_minItemSizeToFragment=
iped_libreOfficeThumbs=
iped_libreOfficeTimeout=
iped_maxPdfExternalMemory=
iped_pdfThumbs=
iped_pdfTimeout=
iped_thumbSize=
iped_timeoutIncPerMB=
iped_enableExternalParsing=
iped_externalParsingMaxMem=
iped_minRawStringSize=
iped_numExternalParsers=
iped_parseCorruptedFiles=
iped_parseUnknownFiles=
iped_phoneParsersToUse=
iped_processImagesInPDFs=
iped_sortPDFChars=
iped_storeTextCacheOnDisk=
iped_timeOut=
iped_timeOutPerMB=
iped_computeFromThumbnail=
iped_minFileSize=
iped_skipHashDBFiles=
iped_phone_region=


```

