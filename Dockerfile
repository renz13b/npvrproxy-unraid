FROM alpine:3.6

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

# Install core packages
RUN apk add --no-cache \
        ca-certificates \
        coreutils \
        tzdata && \

# Install build packages
    apk add --no-cache --virtual=build-dependencies \
        wget && \

# Create user
    adduser -H -D -S -u 99 -G users -s /sbin/nologin duser && \

# Install runtime packages
    apk add --no-cache \
        python \
        py-flask \
        py-requests \
        py-gevent && \

# Install npvrproxy
    mkdir -p /opt/npvrproxy && \
    wget -qO /opt/npvrproxy/npvrProxy.py "https://raw.githubusercontent.com/renz13b/npvrproxy-unraid/master/npvrProxy.py" && \

# Cleanup
    apk del --purge build-dependencies && \
    rm -rf /var/cache/apk/* /tmp/* && \

# Set file permissions
    chmod +x /docker-entrypoint.sh /opt/npvrproxy/npvrProxy.py

ENTRYPOINT ["/docker-entrypoint.sh"]
