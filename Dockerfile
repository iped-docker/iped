FROM ubuntu:xenial-20180417
RUN apt-get update      && \
      apt-get install -y software-properties-common     && \
      add-apt-repository ppa:openjdk-r/ppa -y     && \
      apt-get update && \
      apt-get install -y \
        openjdk-8-jre \
        ant \
        git \
        unzip \
        libafflib-dev zlib1g-dev libewf-dev libvmdk-dev \
        build-essential automake libtool \
        tesseract-ocr tesseract-ocr-por tesseract-ocr-osd \
        libparse-win32registry-perl \
        libesedb-utils \
        imagemagick \
        libmsiecf-utils \
        libpff1 \
        mplayer && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

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
