FROM ghcr.io/linuxserver/baseimage-alpine:3.15 as buildstage

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    shntool && cp /usr/bin/shnsplit /root/

COPY beet_import_all /root/

FROM scratch
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

COPY --from=buildstage /root/ /usr/bin/