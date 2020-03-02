# IPED dockerfiles with AIDESK

![CI](https://github.com/iped-docker/iped/workflows/CI/badge.svg)

We use /mnt folder as default. Adjust this to your environment. 

Install Docker version 19.03.5 and above if you want to use GPU's.

## Docker Image Build 


2 - # git clone https://github.com/iped-docker/iped

3 - # cd iped

4 - Download optional IPED dependencies:

    - PhotoDNA: put jar on "optional_jars" folder and the hashes on /mnt/PhotoDNA folder.
    - Stanford NLP Models: put jar on "optional_jars" folder.
    - Download LED and decompress it on /mnt/led folder.
    - Download iped's KFF and decompress it on /mnt/kff folder.

5 - Adjust LocalConfig.txt and IPEDConfig.txt to your environment 

6 - Build the IPED docker images: 

        docker build -t ipeddocker/iped:dependencies -f Dockerfile-iped-dependencies . && \
        docker build -t ipeddocker/iped:processor -f Dockerfile-iped-processor . && \
        docker build -t ipeddocker/iped:client -f Dockerfile-iped-client .
                           
7 - (OPTIONAL) Build AI.DESK docker image: 

        docker build -t ipeddocker/aidesk -f Dockerfile-aidesk .

## Adjusting the environment for execution

8 - Insert the folowing lines into .bashrc 

    xhost +
    dkr () { docker run --rm -it -v "`pwd`":"`pwd`":Z -e DISPLAY -e GDK_BACKEND -e GDK_SCALE -e GDK_DPI_SCALE -e QT_DEVICE_PIXEL_RATIO -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 -e NO_AT_BRIDGE=1 --device /dev/dri --device /dev/snd -v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix/:/tmp/.X11-unix/ "$@"; }
    export -f dkr

9 - Restart the terminal 

## Executing the containers

### IPED docker

    dkr -v /mnt/evidences:/evidences -v /mnt/optional_jars:/root/IPED/optional_jars -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/iped:processor java -jar iped.jar -d /evidences/test/test.dd -o /evidences/test/iped-output


### AIDESK Docker

    dkr -e AIDESK_BASE_PATH=/mnt/ipedtmp/aidesk-tmp/ --gpus '"device=1"' -v `pwd`/aidesk_dist:/root/IPED/aidesk -v /mnt/evidences:/evidences -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/aidesk bash


