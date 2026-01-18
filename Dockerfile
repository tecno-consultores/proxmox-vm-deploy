FROM ubuntu:24.04
LABEL maintainer="sinfallas@gmail.com"
LABEL build_date="2025-01-19"
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
RUN apt update -qq && apt -y dist-upgrade && apt -y install --no-install-recommends --no-install-suggests tzdata && apt -y install --no-install-recommends --no-install-suggests nginx libnginx-mod-stream ca-certificates git libnet-ssleay-perl libcrypt-ssleay-perl tar zip unzip ssh sshpass sshfs samba-client swaks nano wget curl rsync expect && apt clean && apt -y autoremove && rm -rf /var/lib/{apt,dpkg,cache,log} && rm -rf /var/cache/* && rm -rf /var/log/apt/* && rm -rf /tmp/*
RUN mkdir -p /var/www/html/downloads
COPY COPYING ./
COPY default.conf /etc/nginx/conf.d/default.conf
COPY vm-deploy /usr/bin/vm-deploy
RUN chmod 777 /usr/bin/vm-deploy
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
