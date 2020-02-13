# Instructions to build docker container for IPED e AIDESK

We use /mnt folder as default. Adjust this to your environment. 


## Docker Image Build 


1 - Install Docker version 19.03.5 and above if you want to use GPU's.

2 - # git clone https://github.com/iped-docker/iped

3 - # cd iped/precompiled

4 - Download optional IPED dependencies:

    - PhotoDNA: put jar on "optional_jars" folder and the hashes on /mnt/PhotoDNA folder
    - Download LED and decompress it on /mnt/led folder.
    - Download iped's KFF and decompress it on /mnt/kff folder.

5 - Adjust LocalConfig.txt and IPEDConfig.txt to your environment 

6 - Become superuser (sudo su)

7 - Build the IPED docker images: # docker build -t ipeddocker/iped:dependencies -f Dockerfile-iped-dependencies . && \ 
                                    docker build -t ipeddocker/iped:processor -f Dockerfile-iped-procesor . &&  \
                                    docker build -t ipeddocker/iped:client -f Dockerfile-iped-client .
                           
8 - (OPTIONAL) Build AI.DESK docker image: # docker build -t ipeddocker/aidesk -f Dockerfile-aidesk .

## Adjusting the environment for execution

9 - Insert the folowing lines on the .bashrc 

'xhost +

'dkr () { sudo docker run --rm -it -v "`pwd`":"`pwd`":Z -e DISPLAY -e GDK_BACKEND -e GDK_SCALE -e GDK_DPI_SCALE -e QT_DEVICE_PIXEL_RATIO -e LANG=C.UTF-8 -e LC_ALL=C.UTF-8 --device /dev/dri --device /dev/snd -v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix/:/tmp/.X11-unix/ "$@"; }

10 - Restart the terminal 

## Execute the containers

### IPED docker

- # dkr -v /mnt/evidences:/evidences -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/iped:processor java -jar iped/iped.jar -d /evidences/


### AIDESK Docker

- # dkr -e AIDESK_BASE_PATH=/mnt/ipedtmp/aidesk-tmp/ --gpus '"device=1"' -v `pwd`/aidesk_dist:/root/IPED/aidesk -v /mnt/evidences:/evidences -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/aidesk bash











