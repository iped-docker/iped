#to always run
.PHONY: Dockerfile

Dockerfile: Dockerfile-processor Dockerfile-client.in
	cat Dockerfile-processor Dockerfile-client.in > Dockerfile
