FROM ubuntu:16.04
ARG DEBIAN_FRONTEND="noninteractive"
ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

RUN apt-get update \
    && apt-get install --yes --quiet --no-install-recommends \
        ca-certificates \
        curl \
        git \
        libgomp1 \
        python3 \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://bootstrap.pypa.io/get-pip.py | python3 - \
    && ln -s $(which python3) /usr/local/bin/python

WORKDIR /opt/ams
COPY [".", "."]
RUN pip install --no-cache-dir --editable .[cpu]

ENV FREESURFER_HOME="/opt/ams/freesurfer"
ENV PATH="$FREESURFER_HOME/bin:$PATH"

WORKDIR /data
ENTRYPOINT ["ams"]
LABEL maintainer="Jakub Kaczmarzyk <jakub.kaczmarzyk@gmail.com>"