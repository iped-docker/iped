FROM openjdk:8u171-jre-stretch
RUN apt-get update \
&&  apt-get install -y \
      git \
      mplayer \
      tesseract-ocr tesseract-ocr-por tesseract-ocr-osd \
      libparse-win32registry-perl \
      libesedb-utils \
      graphicsmagick \
      libmsiecf-utils \
      libafflib-dev zlib1g-dev libewf-dev libvmdk-dev \
      libxtst6 libxi6 \
      libpff1 \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

#creates .mplayer/config
RUN mplayer

COPY --from=ipeddocker/sleuthkit:sleuthkit-4.6.0-patch01 /usr/local/src/sleuthkit/sleuthkit.tar.gz /tmp/
RUN tar xkf /tmp/sleuthkit.tar.gz -C /
RUN ldconfig

WORKDIR /opt
RUN git clone https://github.com/keydet89/RegRipper2.8.git
RUN echo '/usr/bin/perl /opt/RegRipper2.8/rip.pl "$@"' > /usr/bin/rip
RUN chmod +x /usr/bin/rip

COPY iped/iped-3.14.3 /root/IPED/iped
COPY iped/mplayer /root/IPED/mplayer
COPY iped/optional_jars /root/IPED/optional_jars
COPY iped/regripper /root/IPED/regripper
COPY LocalConfig.txt /root/IPED/iped/LocalConfig.txt
WORKDIR /root/IPED/iped
ENV LC_ALL C.UTF-8
