FROM alpine:latest

MAINTAINER Port Direct <pete@port.direct>

RUN set -e && \
    set -x && \
    apk upgrade --no-cache && \
    apk add --no-cache --virtual run-deps \
        python && \
    python -m ensurepip && \
    pip --no-cache-dir install --upgrade pip setuptools && \
    pip --no-cache-dir install pyyaml

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

ENTRYPOINT ["/bin/sh"]
