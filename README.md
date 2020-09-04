# IPED dockerfile

![CI/CD](https://github.com/iped-docker/iped/workflows/CI/CD/badge.svg)

![Docker hub](https://dockeri.co/image/ipeddocker/iped)


## Help can be achieved with the command:
```
sudo docker run ipeddocker/iped:processor java -jar iped.jar
```

## Adjusting the environment for execution

The IPED java graphical interface is optional. To use it, configure the docker environment to use a X server. We created a script (the script dkr.source) to easily deploy/execute IPED on X graphical local enviroments.

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

## To run without a graphical interface

Use the option --nogui


## Docker Image Build 
    
Docker images are already automatically built. The following instructions are meant for those who want to build the images from source.

 
    ```
    git clone https://github.com/iped-docker/iped
    cd iped
    make
    ```
    
