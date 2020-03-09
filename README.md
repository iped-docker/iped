# IPED dockerfiles with AIDESK

![CI/CD](https://github.com/iped-docker/iped/workflows/CI/CD/badge.svg)

![Docker hub](https://dockeri.co/image/ipeddocker/iped)

Install Docker version 19.03.5 and above if you want to use GPU's.

## Help can be achieved with the command:
```
sudo docker run ipeddocker/iped:processor java -jar iped.jar
```

## About the container "flavors"

- ipeddocker/iped - Full processing and analysis capable environment (larger container)

- ipeddocker/iped:processor - Environment optimized for evidence processing (smaller container)

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

### IPED docker (Processing)

```
    sudo dkr -v /mnt/evidences:/evidences \
                   -v /mnt/ipedtmp:/mnt/ipedtmp \
                   -v /mnt/optional_jars:/root/IPED/optional_jars \
                   -v /mnt/led/:/mnt/led \
                   -v /mnt/PhotoDNA:/mnt/PhotoDNA \
                   -v /mnt/kff:/mnt/kff \
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

### AIDESK Docker (container not available yet)

```
    sudo dkr -e AIDESK_BASE_PATH=/mnt/ipedtmp/aidesk-tmp/ \
          --gpus '"device=1"' \
          -v `pwd`/aidesk_dist:/root/IPED/aidesk \ 
          -v /mnt/evidences:/evidences \ 
          -v /mnt/ipedtmp:/mnt/ipedtmp \
          ipeddocker/aidesk bash
```

## To run without a graphical interface

If you just want to process the evidences with latest docker (again, without building or customizing it), in text mode and without analysis interface on linux (graphical analysis of the resulting case can be made afterwards in another computer for example, running Windows or Linux), use the following command:

```
sudo docker run -v /mnt/evidences:/evidences \ 
                 -v /mnt/ipedtmp:/mnt/ipedtmp \
                 -v /mnt/optional_jars:/root/IPED/optional_jars \
                 -v /mnt/led/:/mnt/led \
                 -v /mnt/ipedtmp:/mnt/ipedtmp \
                 -v /mnt/PhotoDNA:/mnt/PhotoDNA \
                 -v /mnt/kff:/mnt/kff \
                   ipeddocker/iped:processor java -jar iped.jar --nogui \
                 -d /evidences/test/test.dd \
                 -o /evidences/test/iped-output 
```

It can be used without the optional features also. We recommend that at least the evidences and temporary folder be used as volumes:
```
sudo docker run -v /mnt/evidences:/evidences \ 
                 -v /mnt/ipedtmp:/mnt/ipedtmp \
                 ipeddocker/iped:processor java -jar iped.jar --nogui \
                 -d /evidences/test/test.dd \
                 -o /evidences/test/iped-output
```
Of course, in both cases you'll have to change the volumes to reflect your environment.


## Docker Image Build 
    
Docker images are already automatically built. The following instructions are meant for those who want to build the images from source.

1. Clone the repository
 
    ```
    git clone https://github.com/iped-docker/iped
    cd iped
    ```
    
2. (Optional) Download optional IPED dependencies:
    The default config files are configured to use these directories inside the docker:
    
    - PhotoDNA: /mnt/PhotoDNA and /root/IPED/optional_jars
    - Stanford NLP Models: /root/IPED/optional_jars
    - LED: /mnt/led 
    - KFF: /mnt/kff 
    
    If these directories are empty, the entrypoint.sh will disable these features.

    Note: You don't need to change it, it is completely optional, but if you want to change default values for the internal container directories, you can adjust LocalConfig.txt and IPEDConfig.txt to your environment before building it. You just have to take care when configuring the docker volumes. 

3.  Build the IPED docker images: 
    ```
    docker build . -t ipeddocker/iped
    ```
    
    

