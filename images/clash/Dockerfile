FROM docker.io/library/debian:testing
LABEL org.opencontainers.image.source https://github.com/fancl20/containers

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      iproute2 nftables procps curl jq unzip dumb-init && \
    # Install clash premium
    mkdir -p /opt/bin && \
    curl -s --fail -L $(curl -s --fail -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/Dreamacro/clash/releases/tags/premium \
      | jq -r '.assets[] | select(.name | startswith("clash-linux-amd64-")) | .browser_download_url') \
    | gzip -d > /opt/bin/clash && chmod +x /opt/bin/clash && \ 
    # Install clash dashboard
    mkdir -p /root/.config/clash/ && \
    curl -s --fail -L -o /tmp/clash-dashboard.zip https://github.com/Dreamacro/clash-dashboard/archive/gh-pages.zip  && \
    unzip /tmp/clash-dashboard.zip -d /root/.config/clash/ && rm /tmp/clash-dashboard.zip && \
    curl -o /root/.config/clash/Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb && \
    # Cleanup
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENTRYPOINT ["dumb-init"]
CMD ["/opt/bin/clash"]