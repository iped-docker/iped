#!/bin/bash -ex
(cd dependencies; docker build . -t ipeddocker/dependencies)
(cd precompiled; docker build . -t ipeddocker/precompiled)
(cd build; docker build . -t ipeddocker/build)
