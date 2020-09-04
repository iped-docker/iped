IPED_VERSION=3.18.2

centos8: IPED-${IPED_VERSION}_and_extra_tools.zip
	docker build . -f Dockerfile-centos8

IPED-${IPED_VERSION}_and_extra_tools.zip:
	wget  https://github.com/sepinf-inc/IPED/releases/download/${IPED_VERSION}/IPED-${IPED_VERSION}_and_extra_tools.zip

.PHONY: centos8
