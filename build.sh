#!/bin/bash -ex
(cd dependencies; docker build . -t ipeddocker/dependencies)
(cd runtime; docker build . -t ipeddocker/runtime)
(cd build; docker build . -t ipeddocker/build)
