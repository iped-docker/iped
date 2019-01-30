FROM ipeddocker/dependencies

COPY iped/iped-3.15.1 /root/IPED/iped
# MAPLAYER eh externo (dependencies)
# COPY iped/mplayer /root/IPED/mplayer
COPY iped/optional_jars /root/IPED/optional_jars
# Usando REGRIPPER externo (dependencies)
# COPY iped/regripper /root/IPED/regripper
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
#RUN /bin/bash -c "sed -i 's/enableExternalParsing = false/enableExternalParsing = true/g' /root/IPED/iped/conf/AdvancedConfig.txt"
#RUN /bin/bash -c "sed -i 's/enableExternalParsing = false/enableExternalParsing = true/g' /root/IPED/iped/profiles/*/*/conf/AdvancedConfig.txt"
#RUN /bin/bash -c "sed -i 's/externalParsingMaxMem = 512M/externalParsingMaxMem = 256M/g' /root/IPED/iped/conf/AdvancedConfig.txt"
#RUN /bin/bash -c "sed -i 's/externalParsingMaxMem = 512M/externalParsingMaxMem = 256M/g' /root/IPED/iped/profiles/*/*/conf/AdvancedConfig.txt"
#RUN /bin/bash -c "sed -i 's/numExternalParsers = auto/numExternalParsers = 8/g' /root/IPED/iped/conf/AdvancedConfig.txt"
#RUN /bin/bash -c "sed -i 's/numExternalParsers = auto/numExternalParsers = 8/g' /root/IPED/iped/profiles/*/*/conf/AdvancedConfig.txt"
WORKDIR /root/IPED/iped
