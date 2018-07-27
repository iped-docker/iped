FROM openjdk:8-jre-slim
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

COPY iped-3.14.3 /root/IPED
WORKDIR /root/
RUN git clone --branch sleuthkit-4.6.0 https://github.com/sleuthkit/sleuthkit
WORKDIR /root/sleuthkit
RUN unzip /root/IPED/iped-3.14.2/sources/tsk-iped-patch-zip-4.6.0-p01.zip
RUN patch -p1 < sleuthkit-4.6.0-patch01/tsk-4.6.0-p01.patch
RUN ./bootstrap && \
    ./configure --prefix=/usr && \
    make all install
RUN mplayer
