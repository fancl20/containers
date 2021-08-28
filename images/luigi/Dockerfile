FROM docker.io/library/python:alpine
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

RUN pip install luigi pykube && \
    mkdir -p /etc/luigi /luigi/state

COPY luigi.conf /etc/luigi/

CMD ["luigid"]