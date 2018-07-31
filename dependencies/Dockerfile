FROM openjdk:8u171-jdk-stretch
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

#COPY --from=atilaromero/libyal:libpff-45978e5 /usr/local/src/libpff_20180205-1_amd64.deb /tmp/
#RUN dpkg -i /tmp/libpff_20180205-1_amd64.deb

#COPY --from=atilaromero/libyal:libpff-45978e5 /usr/local/src/libpff-tools_20180205-1_amd64.deb /tmp/
#RUN dpkg -i /tmp/libpff-tools_20180205-1_amd64.deb

WORKDIR /opt
RUN git clone https://github.com/keydet89/RegRipper2.8.git
RUN echo '/usr/bin/perl /opt/RegRipper2.8/rip.pl "$@"' > /usr/bin/rip
RUN chmod +x /usr/bin/rip

RUN wget -P /tmp/ http://mirror.nbtelecom.com.br/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
RUN tar xkf /tmp/apache-maven-3.5.3-bin.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.5.3/bin/mvn /bin/

RUN mvn install:install-file \
      -Dfile=/share/java/Tsk_DataModel.jar \
      -DgroupId=org.sleuthkit \
      -DartifactId=tsk-datamodel \
      -Dversion=4.4.2-p02-c \
      -Dpackaging=jar \
      -DgeneratePom=true

WORKDIR /usr/local/src/iped/
ENV LC_ALL C.UTF-8

CMD /bin/bash
