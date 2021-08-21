LABEL org.opencontainers.image.source https://github.com/fancl20/containers

FROM debian:testing

ADD scripts /tmp/scripts

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        dumb-init openssh-server curl git jq fish build-essential && \
    mkdir /var/run/sshd && \
    # Install commonly used cross projects' dependencies
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && apt-get install -y \
    clang cmake make pkg-config \
    golang nodejs \
    # Install terraform
    python3 /tmp/scripts/install_terraform.py && \
    # Install zig
    mkdir -p /opt/zig && \
    curl -s https://ziglang.org/download/index.json \
    | jq --raw-output '.master."x86_64-linux".tarball' \
    | xargs curl | tar --strip-components=1 -xJC /opt/zig && \
    ln -s /opt/zig/zig /usr/local/bin/ && \
    git clone --recurse-submodules https://github.com/zigtools/zls /opt/zls && \
    (cd /opt/zls && zig build) && \
    ln -s /opt/zls/zig-out/bin/zls /usr/local/bin/ && \
    # Cleanup
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# To get latest stable release of zig:
#   jq --raw-output 'del(.master) | to_entries | sort_by(.value.date) | .[-1].value."x86_64-linux".tarball'

ENTRYPOINT ["dumb-init"]