ARG  VERSION=3.15.6 
FROM alpine as unzipper
ARG  VERSION
WORKDIR /root/IPED
RUN  wget https://servicos.dpf.gov.br/ferramentas/IPED/${VERSION}/IPED-${VERSION}-with-extra-tools.zip .
RUN  unzip IPED-${VERSION}-with-extra-tools.zip
RUN  ln -s iped-${VERSION} iped
RUN  rm IPED-${VERSION}-with-extra-tools.zip 

FROM ipeddocker/dependencies:${VERSION}
COPY --from=unzipper /root/IPED /root/IPED
COPY LocalConfig.txt /root/IPED/iped/

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
