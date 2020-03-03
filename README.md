# IPED dockerfiles with AIDESK

![CI/CD](https://github.com/iped-docker/iped/workflows/CI/CD/badge.svg)

![Docker hub](https://dockeri.co/image/ipeddocker/iped)

Install Docker version 19.03.5 and above if you want to use GPU's.

## Docker Image Build 
1.  ```
    git clone https://github.com/iped-docker/iped
    cd iped
    ```
    
2. (Optional) Download optional IPED dependencies:

    The default config files are configured to use these directories:
    
    - PhotoDNA: /mnt/PhotoDNA and /root/IPED/optional_jars
    - Stanford NLP Models: /root/IPED/optional_jars
    - LED: /mnt/led 
    - KFF: /mnt/kff 
    
    If these directories are empty, the entrypoint.sh will disable these features.

    Adjust LocalConfig.txt and IPEDConfig.txt to your environment 

3.  Build the IPED docker images: 
    ```
    make
    docker build . -t ipeddocker/iped
    ```
    
## Adjusting the environment for execution

The script dkr.source creates a bash function dkr that extends the docker command, setting some usefull docker options.

To use it:

```
source dkr.source
dkr ipeddocker/iped
```

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

## Executing the containers

### IPED docker

    dkr -v /mnt/evidences:/evidences -v /mnt/optional_jars:/root/IPED/optional_jars -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/iped:processor java -jar iped.jar -d /evidences/test/test.dd -o /evidences/test/iped-output


### AIDESK Docker

    dkr -e AIDESK_BASE_PATH=/mnt/ipedtmp/aidesk-tmp/ --gpus '"device=1"' -v `pwd`/aidesk_dist:/root/IPED/aidesk -v /mnt/evidences:/evidences -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/aidesk bash


