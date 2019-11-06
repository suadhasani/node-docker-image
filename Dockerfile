FROM adoptopenjdk/openjdk12:x86_64-ubuntu-jdk-12.0.2_10-slim
ENV WAVES_VERSION="latest"
ENV WAVES_LOG_LEVEL="DEBUG"
ENV WAVES_HEAP_SIZE="2g"
ENV WAVES_CONFIG_FILE="/waves/configs/waves-config.conf"

MAINTAINER Inal Kardanov <ikardanov@wavesplatform.com> (@ikardanov)

# Install python
RUN apt-get update -y && apt-get install -y python3 \
    python3-pip \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip


RUN pip3 install requests pyhocon pywaves==0.8.22 tqdm

WORKDIR /waves-node

RUN install -m 0775 -d /waves -d /waves-node
COPY starter.py /waves-node
COPY entrypoint.sh /waves-node
RUN chmod 777 /waves-node/entrypoint.sh

VOLUME /waves
EXPOSE 6869 6868 6863 6864
ENTRYPOINT ["/waves-node/entrypoint.sh"]
