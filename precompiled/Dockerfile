ARG  VERSION=3.15.6 
FROM ipeddocker/dependencies:${VERSION}
ARG  VERSION

COPY iped/iped-${VERSION} /root/IPED/iped
COPY iped/optional_jars /root/IPED/optional_jars
COPY LocalConfig.txt /root/IPED/iped/

# Desabilitando o agdbinfo que esta bugado
COPY ExternalParsers.xml /root/IPED/iped/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/forensic/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/pedo/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/blind/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/fastmode/conf/ExternalParsers.xml
COPY ExternalParsers.xml /root/IPED/iped/profiles/pt-BR/triage/conf/ExternalParsers.xml

#Ajuste pontuais de configuracao
RUN /bin/bash -c "sed -i 's/excludeKffIgnorable = false/excludeKffIgnorable = true/g' /root/IPED/iped/IPEDConfig.txt"
RUN /bin/bash -c "sed -i 's/excludeKffIgnorable = false/excludeKffIgnorable = true/g' /root/IPED/iped/profiles/*/*/IPEDConfig.txt"
WORKDIR /root/IPED/iped
