FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        build-essential \
        ca-certificates \
        curl \
        dnsutils \
        git \
        iproute2 \
        iputils-ping \
        less \
        nano \
        openssh-client \
        procps \
        sudo \
        vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# The container remains available for `docker exec -it <name> bash`.
CMD ["sleep", "infinity"]