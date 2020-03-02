FROM nvidia/cuda:10.2-base

WORKDIR /root/pkgs
RUN apt-get update && apt-get install -y \
      git \
      build-essential \
      libafflib-dev zlib1g-dev libewf-dev unzip patch libssl-dev \
      autoconf automake autopoint libtool pkg-config yasm gettext wget \
      libaa1-dev libasound2-dev libcaca-dev libcdparanoia-dev libdca-dev \
      libdirectfb-dev libenca-dev libfontconfig1-dev libfreetype6-dev \
      libfribidi-dev libgif-dev libgl1-mesa-dev libjack-jackd2-dev libopenal1 libpulse-dev \
      libsdl1.2-dev libvdpau-dev libxinerama-dev libxv-dev libxvmc-dev libxxf86dga-dev \
      libxxf86vm-dev librtmp-dev libsctp-dev libass-dev libfaac-dev libsmbclient-dev libtheora-dev \
      libogg-dev libxvidcore-dev libspeex-dev libvpx-dev libdv4-dev \
      libopencore-amrnb-dev libopencore-amrwb-dev libmp3lame-dev liblivemedia-dev libtwolame-dev \
      libmad0-dev libgsm1-dev libbs2b-dev liblzo2-dev ladspa-sdk libfaad-dev \
      libmpg123-dev libopus-dev libbluray-dev libaacs-dev \
      libjpeg-dev \
      libtiff-dev \
      libpng-dev \
      libwmf-dev \
      libgif-dev \
      libheif-dev \
      libwebp-dev \
      librsvg2-dev \
      libopenexr-dev \
      vim \
      less\
      openjdk-8-jdk \
      unzip \
      openjfx=8u161-b12-1ubuntu2 \
      libopenjfx-java=8u161-b12-1ubuntu2 \
      libopenjfx-jni=8u161-b12-1ubuntu2 \
      libgl1-mesa-dri \
      libparse-win32registry-perl \
      tesseract-ocr tesseract-ocr-por tesseract-ocr-osd \
      && apt-get download ant && ls *.deb | awk '{system("dpkg-deb -x "$1" /")}' \
      && apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR /opt
RUN git clone https://github.com/lfcnassif/sleuthkit-APFS \
    && cd /opt/sleuthkit-APFS/ \
    && ./bootstrap \ 
    && ./configure --prefix=/usr/ \
    && make && make install \
    && rm -rf /opt/sleuthkit-APFS/

WORKDIR /opt
RUN wget --progress=bar:force http://www.mplayerhq.hu/MPlayer/releases/MPlayer-1.4.tar.gz \
    && tar xvzf MPlayer-1.4.tar.gz \
    && cd /opt/MPlayer-1.4 \
    && ./configure --prefix=/usr \
    && make all install \
    && cd /usr/lib \
    && wget --progress=bar:force http://www.mplayerhq.hu/MPlayer/releases/codecs/all-20110131.tar.bz2 \
    && tar xvjf all-20110131.tar.bz2 && mv all-20110131 codecs && rm all-20110131.tar.bz2

WORKDIR /opt
RUN git clone https://github.com/libyal/libagdb.git \
    && cd /opt/libagdb \
    && ./synclibs.sh \
    && ./autogen.sh \    
    && ./configure --prefix=/usr \ 
    && make all install \
    && rm -rf /opt/libagdb

WORKDIR /opt
RUN git clone --branch="20191221" https://github.com/libyal/libevtx \
    && cd /opt/libevtx \ 
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/libevtx

WORKDIR /opt
RUN git clone https://github.com/libyal/libevt \
    && cd /opt/libevt \
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/libevt

WORKDIR /opt
RUN git clone https://github.com/libyal/libscca \
    && cd /opt/libscca \
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/libscca

WORKDIR /opt
RUN git clone https://github.com/libyal/libesedb \
    && cd /opt/libesedb \
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/libesedb

WORKDIR /opt
RUN git clone https://github.com/libyal/libpff \
    && cd /opt/libpff \
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \ 
    && make all install \
    && rm -rf /opt/libpff

WORKDIR /opt
RUN git clone https://github.com/libyal/libmsiecf \
    && cd /opt/libmsiecf \
    && ./synclibs.sh \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/libmsiecf

WORKDIR /opt
RUN git clone https://github.com/abelcheung/rifiuti2 \
    && cd /opt/rifiuti2 \
    && autoreconf -f -i -v \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/rifiuti2

WORKDIR /opt
RUN git clone --branch "7.0.8-14" https://github.com/ImageMagick/ImageMagick \
    && cd /opt/ImageMagick \
    && ./configure --prefix=/usr \
    && make all install \
    && rm -rf /opt/ImageMagick

ENV TZ=Brazil/East
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Creating mplayer config
RUN mplayer

ENV IPED_VERSION=3.17.1

WORKDIR /root/IPED/
RUN wget --progress=bar:force https://github.com/lfcnassif/IPED/releases/download/$IPED_VERSION/IPED-$IPED_VERSION.zip -O iped.zip \
    && unzip iped.zip && rm iped.zip && ln -s iped-$IPED_VERSION iped
# optional_jars will be a volume due its size
# COPY ./optional_jars/* ./
COPY LocalConfig.txt /root/IPED/iped/
COPY IPEDConfig.txt /root/IPED/iped/profiles/pt-BR/default/
COPY IPEDConfig.txt /root/IPED/iped/profiles/en/default/
# Copying custom profiles
# COPY ./fastrobust /root/IPED/iped/profiles/pt-BR/fastrobust
# COPY ./pedorobust /root/IPED/iped/profiles/pt-BR/pedorobust


ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
ENV JDK_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/
ENV J2REDIR=/usr/lib/jvm/java-8-openjdk-amd64/jre/
ENV J2SDKDIR=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin:$PATH

WORKDIR /root/IPED/iped
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# Para abrir o iped-search no docker
RUN apt-get update && apt-get install -y libreoffice libreoffice-java-common \
      libreoffice-gtk2 \
      libgnome2-0 \
      xdg-utils \
      gnome-shell \
      vlc \
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

# commenting line to avoid a bug where clicking on a gallery image would not
# open the image in the viewer
RUN sed -i 's/^assistive_/#assistive_/' /etc/java-8-openjdk/accessibility.properties

ENV SAL_USE_VCLPLUGIN="gtk"

WORKDIR /root/IPED/iped