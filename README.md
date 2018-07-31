# IPED dockerfiles

There are 3 Dockerfiles in this repository:

- dependencies: basic runtime environment, with openjdk and libraries. Used by the other 2 docker images.

- precompiled: Adds the precompiled IPED to the basic environment (which is ipeddocker/dependencies).

- build: Adds maven, m2 cache prefilled dir and IPED source-code to the basic environment. Runs maven in offline mode to compile IPED.

## Requirements

- precompiled/iped <- unpack your precompiled IPED distibution zip file here.

- build/m2 <- use `git submodule update --init --recursive`

- build/iped* <- use `git submodule update --init --recursive`
