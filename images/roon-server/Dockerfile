FROM docker.io/library/debian
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

ENV ROON_DATAROOT /data
ENV ROON_ID_DIR /data

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install bash curl bzip2 ffmpeg cifs-utils alsa-utils libicu72 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir /app && cd /app \
    && curl -L http://download.roonlabs.com/builds/RoonServer_linuxx64.tar.bz2 | tar -xjf -

ENTRYPOINT /app/RoonServer/start.sh