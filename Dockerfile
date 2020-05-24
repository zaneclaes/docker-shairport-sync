FROM ubuntu:18.04
MAINTAINER zane@technicallywizardry.com

RUN apt-get update -y && apt-get install -y \
        build-essential \
        git \
        xmltoman \
        autoconf \
        automake \
        libtool \
        libpopt-dev \
        libconfig-dev \
        libasound2-dev \
        avahi-daemon \
        libavahi-client-dev \
        libssl-dev \
        libsoxr-dev \
        dbus \
        libmosquitto-dev \
        libdaemon-dev \
        libpopt-dev

RUN git clone https://github.com/mikebrady/shairport-sync.git \
        && cd shairport-sync \
        && autoreconf -fi \
        && ./configure --sysconfdir=/etc  \
                --with-alsa \
                --with-pipe \
                --with-avahi \
                --with-ssl=openssl \
                --with-soxr \
                --with-metadata \
                --with-mqtt-client \
        && make \
        && make install

COPY start.sh /start

ENV AIRPLAY_NAME Airplay

ENTRYPOINT [ "/start" ]
