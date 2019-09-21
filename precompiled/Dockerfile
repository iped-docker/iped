ARG  VERSION=3.15.6 
FROM alpine as unzipper
ARG  VERSION
WORKDIR /root/IPED
RUN  apk add --no-cache wget

# RUN  wget https://servicos.dpf.gov.br/ferramentas/IPED/${VERSION}/IPED-${VERSION}-with-extra-tools.zip
RUN wget --no-check-certificate --user 'xxx' --password 'xxx' https://10.61.86.11/dav/Temp/IPED-3.15.6-APFS_patch_experimental.zip
RUN mv IPED-3.15.6-APFS_patch_experimental.zip IPED-3.15.6.zip

# COPY IPED-${VERSION}.zip /root/IPED
RUN  unzip IPED-${VERSION}.zip
RUN  ln -s iped-${VERSION} iped
RUN  rm IPED-${VERSION}.zip 

FROM ipeddocker/dependencies:3.15.6
COPY --from=unzipper /root/IPED /root/IPED
COPY LocalConfig.txt /root/IPED/iped/

COPY --from=tsk-apfs /usr/local/src/sleuthkit/bindings/java/dist/sleuthkit-4.6.5.jar /root/IPED
COPY --from=tsk-apfs /usr/local/src/sleuthkit/sleuthkit.tar.gz /root/IPED
RUN tar xf /root/IPED/sleuthkit.tar.gz -C /

# Desabilitando o agdbinfo que esta bugado
COPY ExternalParsers.xml /root/IPED/iped/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/forensic/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/pedo/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/blind/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/fastmode/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/triage/conf/ExternalParsers.xml

#Ajustes pontuais de configuracao
RUN /bin/bash -c "sed -i 's/excludeKffIgnorable = false/excludeKffIgnorable = true/g' /root/IPED/iped/IPEDConfig.txt"
RUN /bin/bash -c "sed -i 's/excludeKffIgnorable = false/excludeKffIgnorable = true/g' /root/IPED/iped/profiles/*/*/IPEDConfig.txt"
WORKDIR /root/IPED/iped
