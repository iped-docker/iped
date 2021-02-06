FROM ipeddocker/iped:processor

# Para abrir o iped-search no docker
# 
RUN apt-get update && apt-get install -y libreoffice libreoffice-java-common \
      libreoffice-gtk2 \      
      xdg-utils \
      libgl1-mesa-dri \
      vlc \
      packagekit-gtk3-module \
      libcanberra-gtk-module \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /root/.local/share/applications/
RUN mkdir -p /root/.config
RUN xdg-mime default vlc.desktop audio/ogg \
&& xdg-mime default vlc.desktop audio/vorbis \
&& xdg-mime default vlc.desktop audio/x-vorbis \
&& xdg-mime default vlc.desktop audio/x-vorbis+ogg \
&& xdg-mime default vlc.desktop video/ogg \
&& xdg-mime default vlc.desktop video/x-ogm \
&& xdg-mime default vlc.desktop video/x-ogm+ogg \
&& xdg-mime default vlc.desktop video/x-theora+ogg \
&& xdg-mime default vlc.desktop video/x-theora \
&& xdg-mime default vlc.desktop audio/x-speex \
&& xdg-mime default vlc.desktop audio/opus \
&& xdg-mime default vlc.desktop audio/flac \
&& xdg-mime default vlc.desktop audio/x-flac \
&& xdg-mime default vlc.desktop audio/x-ms-asf \
&& xdg-mime default vlc.desktop audio/x-ms-asx \
&& xdg-mime default vlc.desktop audio/x-ms-wax \
&& xdg-mime default vlc.desktop audio/x-ms-wma \
&& xdg-mime default vlc.desktop video/x-ms-asf \
&& xdg-mime default vlc.desktop video/x-ms-asf-plugin \
&& xdg-mime default vlc.desktop video/x-ms-asx \
&& xdg-mime default vlc.desktop video/x-ms-wm \
&& xdg-mime default vlc.desktop video/x-ms-wmv \
&& xdg-mime default vlc.desktop video/x-ms-wmx \
&& xdg-mime default vlc.desktop video/x-ms-wvx \
&& xdg-mime default vlc.desktop video/x-msvideo \
&& xdg-mime default vlc.desktop audio/x-pn-windows-acm \
&& xdg-mime default vlc.desktop video/divx \
&& xdg-mime default vlc.desktop video/msvideo \
&& xdg-mime default vlc.desktop video/vnd.divx \
&& xdg-mime default vlc.desktop video/avi \
&& xdg-mime default vlc.desktop video/x-avi \
&& xdg-mime default vlc.desktop audio/vnd.rn-realaudio \
&& xdg-mime default vlc.desktop audio/x-pn-realaudio \
&& xdg-mime default vlc.desktop audio/x-pn-realaudio-plugin \
&& xdg-mime default vlc.desktop audio/x-real-audio \
&& xdg-mime default vlc.desktop audio/x-realaudio \
&& xdg-mime default vlc.desktop video/vnd.rn-realvideo \
&& xdg-mime default vlc.desktop audio/mpeg \
&& xdg-mime default vlc.desktop audio/mpg \
&& xdg-mime default vlc.desktop audio/mp1 \
&& xdg-mime default vlc.desktop audio/mp2 \
&& xdg-mime default vlc.desktop audio/mp3 \
&& xdg-mime default vlc.desktop audio/x-mp1 \
&& xdg-mime default vlc.desktop audio/x-mp2 \
&& xdg-mime default vlc.desktop audio/x-mp3 \
&& xdg-mime default vlc.desktop audio/x-mpeg \
&& xdg-mime default vlc.desktop audio/x-mpg \
&& xdg-mime default vlc.desktop video/mp2t \
&& xdg-mime default vlc.desktop video/mpeg \
&& xdg-mime default vlc.desktop video/mpeg-system \
&& xdg-mime default vlc.desktop video/x-mpeg \
&& xdg-mime default vlc.desktop video/x-mpeg2 \
&& xdg-mime default vlc.desktop video/x-mpeg-system \
&& xdg-mime default vlc.desktop audio/aac \
&& xdg-mime default vlc.desktop audio/m4a \
&& xdg-mime default vlc.desktop audio/mp4 \
&& xdg-mime default vlc.desktop audio/x-m4a \
&& xdg-mime default vlc.desktop audio/x-aac \
&& xdg-mime default vlc.desktop video/mp4 \
&& xdg-mime default vlc.desktop video/mp4v-es \
&& xdg-mime default vlc.desktop video/x-m4v \
&& xdg-mime default vlc.desktop video/quicktime \
&& xdg-mime default vlc.desktop audio/x-matroska \
&& xdg-mime default vlc.desktop video/x-matroska \
&& xdg-mime default vlc.desktop video/webm \
&& xdg-mime default vlc.desktop audio/webm \
&& xdg-mime default vlc.desktop audio/3gpp \
&& xdg-mime default vlc.desktop audio/3gpp2 \
&& xdg-mime default vlc.desktop audio/AMR \
&& xdg-mime default vlc.desktop audio/AMR-WB \
&& xdg-mime default vlc.desktop video/3gp \
&& xdg-mime default vlc.desktop video/3gpp \
&& xdg-mime default vlc.desktop video/3gpp2 \
&& xdg-mime default vlc.desktop x-content/video-vcd \
&& xdg-mime default vlc.desktop x-content/video-svcd \
&& xdg-mime default vlc.desktop x-content/video-dvd \
&& xdg-mime default vlc.desktop x-content/audio-cdda \
&& xdg-mime default vlc.desktop x-content/audio-player \
&& xdg-mime default vlc.desktop audio/mpegurl \
&& xdg-mime default vlc.desktop audio/x-mpegurl \
&& xdg-mime default vlc.desktop audio/scpls \
&& xdg-mime default vlc.desktop audio/x-scpls \
&& xdg-mime default vlc.desktop video/vnd.mpegurl \
&& xdg-mime default vlc.desktop audio/dv \
&& xdg-mime default vlc.desktop video/dv \
&& xdg-mime default vlc.desktop audio/x-aiff \
&& xdg-mime default vlc.desktop audio/x-pn-aiff \
&& xdg-mime default vlc.desktop video/x-anim \
&& xdg-mime default vlc.desktop video/x-nsv \
&& xdg-mime default vlc.desktop video/fli \
&& xdg-mime default vlc.desktop video/flv \
&& xdg-mime default vlc.desktop video/x-flc \
&& xdg-mime default vlc.desktop video/x-fli \
&& xdg-mime default vlc.desktop video/x-flv \
&& xdg-mime default vlc.desktop audio/wav \
&& xdg-mime default vlc.desktop audio/x-pn-au \
&& xdg-mime default vlc.desktop audio/x-pn-wav \
&& xdg-mime default vlc.desktop audio/x-wav \
&& xdg-mime default vlc.desktop audio/x-adpcm \
&& xdg-mime default vlc.desktop audio/ac3 \
&& xdg-mime default vlc.desktop audio/eac3 \
&& xdg-mime default vlc.desktop audio/vnd.dts \
&& xdg-mime default vlc.desktop audio/vnd.dts.hd \
&& xdg-mime default vlc.desktop audio/vnd.dolby.heaac.1 \
&& xdg-mime default vlc.desktop audio/vnd.dolby.heaac.2 \
&& xdg-mime default vlc.desktop audio/vnd.dolby.mlp \
&& xdg-mime default vlc.desktop audio/basic \
&& xdg-mime default vlc.desktop audio/midi \
&& xdg-mime default vlc.desktop audio/x-ape \
&& xdg-mime default vlc.desktop audio/x-gsm \
&& xdg-mime default vlc.desktop audio/x-musepack \
&& xdg-mime default vlc.desktop audio/x-tta \
&& xdg-mime default vlc.desktop audio/x-wavpack \
&& xdg-mime default vlc.desktop audio/x-shorten \
&& xdg-mime default vlc.desktop audio/x-it \
&& xdg-mime default vlc.desktop audio/x-mod \
&& xdg-mime default vlc.desktop audio/x-s3m \
&& xdg-mime default vlc.desktop audio/x-xm

# allows the use of vlc as root
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

## commenting line to avoid a bug where clicking on a gallery image would not
## open the image in the viewer
#RUN sed -i 's/^assistive_/#assistive_/' /etc/java-8-openjdk/accessibility.properties

# For libreoffice java plugin use
ENV SAL_USE_VCLPLUGIN="gtk"
# For gllibs conflict resolution
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64"

WORKDIR /root/IPED/iped
