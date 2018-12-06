FROM ipeddocker/dependencies

RUN wget -P /tmp/ http://mirror.nbtelecom.com.br/apache/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
RUN tar xkf /tmp/apache-maven-3.5.3-bin.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.5.3/bin/mvn /bin/

COPY m2 /root/.m2/

RUN mvn install:install-file \
      -Dfile=/usr/share/java/sleuthkit-4.6.0.jar \
      -DgroupId=org.sleuthkit \
      -DartifactId=tsk-datamodel \
      -Dversion=4.6.0 \
      -Dpackaging=jar \
      -DgeneratePom=true

WORKDIR /usr/local/src/iped/iped-ahocorasick/
COPY iped-ahocorasick .
RUN mvn -o install

WORKDIR /usr/local/src/iped/iped-utils/
COPY iped-utils .
RUN mvn -o install

WORKDIR /usr/local/src/iped/iped-parsers/
COPY iped-parsers .
RUN mvn -o install

WORKDIR /usr/local/src/iped/iped-viewers/
COPY iped-viewers .
RUN mvn -o install

WORKDIR /usr/local/src/iped/iped/
COPY iped .
RUN mvn -o install

WORKDIR /usr/local/src/iped/iped-webapi/
COPY iped-webapi .
#RUN mvn -o install

ENV IPED_VER 3.14.3
#RUN chmod -R a+rwX /usr/local/src/iped/
RUN ln -s /usr/local/src/iped/iped/target/release/iped-$IPED_VER /iped
RUN cp target/release/iped-webapi.jar /iped

WORKDIR /usr/local/src/iped/iped/resources/config
RUN mv -n IPEDConfig.txt conf/
RUN ln -s conf/IPEDConfig.txt IPEDConfig.txt
RUN mv -n  LocalConfig.txt conf/
RUN ln -s conf/LocalConfig.txt LocalConfig.txt
RUN echo >> conf/LocalConfig.txt
RUN echo 'tskJarPath = /usr/share/java/sleuthkit-4.6.0.jar' >> conf/LocalConfig.txt
RUN cp IPEDConfig.txt /iped/
RUN cp LocalConfig.txt /iped/
RUN cp -a conf/ /iped/

ADD https://github.com/patric-r/jvmtop/releases/download/0.8.0/jvmtop-0.8.0.tar.gz /usr/local/src/jvmtop/
WORKDIR /usr/local/src/jvmtop/
RUN tar xzf jvmtop-0.8.0.tar.gz
RUN chmod +x /usr/local/src/jvmtop/jvmtop.sh
RUN echo '#!/bin/bash' > /usr/bin/jvmtop
RUN echo 'exec /usr/local/src/jvmtop/jvmtop.sh "$@"' >> /usr/bin/jvmtop
RUN chmod +x /usr/bin/jvmtop

RUN useradd -m user
RUN chmod -R a+rwX /home/user

WORKDIR /iped/
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

##CMD bash -xc 'java -Djava.awt.headless=true -Xmx$Xmx -jar /iped/iped.jar -d $IMAGE -o $OUTPUT --nologfile --nogui --portable'
RUN mkdir -p /usr/local/src/sleuthkit/bindings/java/dist/T
RUN cp /usr/share/java/sleuthkit-4.6.0.jar /usr/local/src/sleuthkit/bindings/java/dist/Tsk_DataModel.jar
CMD bash
