#!/bin/bash -ex
(cd dependencies; docker build . -t ipeddocker/dependencies)
(cd ../iped/precompiled; docker build . -t 192.168.2.191:5001/ipeddocker/iped:3.15)
