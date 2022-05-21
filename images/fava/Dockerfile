# https://github.com/beancount/fava/blob/main/contrib/docker/Dockerfile

FROM python:alpine as builder
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

RUN apk add --update libxml2-dev libxslt-dev gcc musl-dev g++
RUN pip install --prefix="/install" fava

FROM python:alpine

COPY --from=builder /install /usr/local

ENV FAVA_HOST "0.0.0.0"
EXPOSE 5000
