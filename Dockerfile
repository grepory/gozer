FROM quay.io/opsee/vinz
MAINTAINER Greg Poirier <greg@opsee.co>

ENV PATH="/gozer/bin:/bin:/sbin:/usr/bin:/usr/sbin:/opt/bin:/usr/local/bin:/usr/local/sbin"

RUN apk --update add openvpn bash curl && \
    mkdir -p /gozer/bin && \
    mkdir -p /gozer/state && \
    curl -Lo /opt/bin/ec2-env https://s3-us-west-2.amazonaws.com/opsee-releases/go/ec2-env/ec2-env && \
    chmod 755 /opt/bin/ec2-env && \
    ln -sf /gozer/common/tls-auth.key /gozer/state/tls-auth.key && \
    ln -sf /gozer/server/server.sh /gozer/bin/server && \
    ln -sf /gozer/client/client.sh /gozer/bin/client && \
    curl -Lo /gozer/bin/auth https://s3-us-west-2.amazonaws.com/opsee-releases/go/zuul/auth && \
    chmod 755 /gozer/bin/auth && \
    openssl dhparam -out /gozer/state/dh1024.pem 1024 && \
    adduser -D -g '' -h /gozer -H -s /sbin/nologin gozer && \
    passwd -u gozer

COPY . /gozer

RUN chown -R gozer:gozer /gozer

CMD ["/bin/bash"]
