from ubuntu:focal

RUN apt update && apt dist-upgrade -y
# we need to setup tzdata otherwise focal ask for time zone
RUN DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    apt install -y build-essential cmake git-core \
    libmariadb-dev libmariadbclient-dev libmariadb-dev-compat \
    libssl-dev \
    libboost-system1.71-dev libboost-thread1.71-dev libboost-program-options1.71-dev libboost-regex1.71-dev

WORKDIR /work

ENTRYPOINT /bin/bash

# WE DO NOT CREATE A MAGOS USER HERE!!

# docker build . -t mongo-build
# docker run -v$(pwd)/app:/app -v $(pwd):/work --rm -it mongo-build  bash
# mkdir build && cd build
# cmake -DCMAKE_INSTALL_PREFIX=/app ../mangos -DBUILD_EXTRACTORS=ON
