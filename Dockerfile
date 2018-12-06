FROM ipeddocker/dependencies:3.13.5

ENV GIT_SSL_NO_VERIFY=true
ENV LANG C.UTF-8
ARG GITLAB_IP
ENV GITLAB_IP=${GITLAB_IP}

ENV IPED_AHOCORASICK_VER=v1.0
WORKDIR /usr/local/src/iped/iped-ahocorasick/
RUN git clone https://$GITLAB_IP/gitlab/iped/iped-ahocorasick.git .
RUN git checkout $IPED_AHOCORASICK_VER
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install

ENV IPED_UTILS_VER=3.13.5
WORKDIR /usr/local/src/iped/iped-utils/
RUN git clone https://$GITLAB_IP/gitlab/iped/iped-utils.git .
RUN git checkout $IPED_UTILS_VER
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install

ENV IPED_PARSERS_VER=3.13.5
WORKDIR /usr/local/src/iped/iped-parsers/
RUN git clone https://$GITLAB_IP/gitlab/iped/iped-parsers.git .
RUN git checkout $IPED_PARSERS_VER
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install

ENV IPED_VIEWERS_VER=3.13.5
WORKDIR /usr/local/src/iped/iped-viewers/
RUN git clone https://$GITLAB_IP/gitlab/iped/iped-viewers.git .
RUN git checkout $IPED_VIEWERS_VER
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install

ENV IPED_VER=3.13.5
WORKDIR /usr/local/src/iped/iped/
RUN git clone https://$GITLAB_IP/gitlab/iped/iped.git .
RUN git checkout $IPED_VER
RUN grep FSDirectory -l src/main/java/dpf/sp/gpinf/indexer/process/ -r | xargs sed -e 's,FSDirectory,NIOFSDirectory,g' -i
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install ||  mvn $MVN_OPTIONS install

ENV IPED_WEBAPI_VER=3.13.5
WORKDIR /usr/local/src/iped/iped-webapi/
RUN git clone https://$GITLAB_IP/gitlab/atila.alr/iped-webapi.git .
RUN git checkout $IPED_WEBAPI_VER
ENV MVN_OPTIONS="-Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8"
RUN mvn $MVN_OPTIONS install

#RUN sed -e 's/getInstance().logConfiguration.getSystemOut()/System.out/' -i /usr/local/src/iped/iped/src/main/java/dpf/sp/gpinf/indexer/IndexFiles.java

RUN chmod -R a+rwX /usr/local/src/iped/
RUN ln -s /usr/local/src/iped/iped/target/release/iped-$IPED_VER /iped
RUN cp target/release/iped-webapi.jar /iped/ 

WORKDIR /usr/local/src/iped/iped/resources/config
RUN mv -n IPEDConfig.txt conf/
RUN ln -s conf/IPEDConfig.txt IPEDConfig.txt
RUN mv -n  LocalConfig.txt conf/
RUN ln -s conf/LocalConfig.txt LocalConfig.txt
RUN echo >> conf/LocalConfig.txt
RUN echo 'tskJarPath = /share/java/Tsk_DataModel.jar' >> conf/LocalConfig.txt
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

CMD bash -xc 'java -Djava.awt.headless=true -Xmx$Xmx -jar /iped/iped.jar -d $IMAGE -o $OUTPUT --nologfile --nogui --portable'
