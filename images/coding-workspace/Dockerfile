FROM docker.io/library/debian:testing
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

ADD scripts /tmp/scripts

ENV PIPX_HOME=/opt/pipx
ENV PIPX_BIN_DIR=/usr/local/bin

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        dumb-init openssh-server curl wget git jq fish build-essential python3-venv pipx && \
    mkdir /var/run/sshd && \
    # Install commonly used cross projects' dependencies
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get update && apt-get install -y \
    clang cmake make pkg-config \
    golang nodejs && \
    # Install terraform
    python3 /tmp/scripts/install_terraform.py && \
    # Install beancount
    pipx install git+https://github.com/beancount/beancount#egg=beancount && \
    # Install zig
    mkdir -p /opt/zig && \
    curl -s https://ziglang.org/download/index.json \
    | jq --raw-output '.master."x86_64-linux".tarball' \
    | xargs curl | tar --strip-components=1 -xJC /opt/zig && \
    ln -s /opt/zig/zig /usr/local/bin/ && \
    # Install Visual Studio Code Server
    mkdir -p /opt/vscode-server && \
    curl -sL -o /opt/vscode-server/code-server https://aka.ms/vscode-server-launcher/x86_64-unknown-linux-gnu && \
    chmod +x /opt/vscode-server/code-server && \
    ln -s /opt/vscode-server/code-server /usr/local/bin/ && \
    # Cleanup
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# To get latest stable release of zig:
#   jq --raw-output 'del(.master) | to_entries | sort_by(.value.date) | .[-1].value."x86_64-linux".tarball'

ENTRYPOINT ["dumb-init"]