# IPED dockerfiles with AIDESK

![CI](https://github.com/iped-docker/iped/workflows/CI/badge.svg)

![Docker hub](https://dockeri.co/image/ipeddocker/iped)

Install Docker version 19.03.5 and above if you want to use GPU's.

## Docker Image Build 
1.  ```
    git clone https://github.com/iped-docker/iped
    cd iped
    ```
    
2. (Optional) Download optional IPED dependencies:
    The default config files are configured to use these directories:
    
    - PhotoDNA: /mnt/PhotoDNA and /root/IPED/iped/optional_jars
    - Stanford NLP Models: /root/IPED/iped/optional_jars
    - LED: /mnt/led folder
    - KFF: /mnt/kff folder
    
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
## Executing the containers

### IPED docker

    dkr -v /mnt/evidences:/evidences -v /mnt/optional_jars:/root/IPED/optional_jars -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/iped:processor java -jar iped.jar -d /evidences/test/test.dd -o /evidences/test/iped-output


### AIDESK Docker

    dkr -e AIDESK_BASE_PATH=/mnt/ipedtmp/aidesk-tmp/ --gpus '"device=1"' -v `pwd`/aidesk_dist:/root/IPED/aidesk -v /mnt/evidences:/evidences -v /mnt/led/:/mnt/led -v /mnt/ipedtmp:/mnt/ipedtmp -v /mnt/PhotoDNA:/mnt/PhotoDNA -v /mnt/kff:/mnt/kff ipeddocker/aidesk bash


