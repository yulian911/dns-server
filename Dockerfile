# MASTER DNS
FROM alpine:3.8
LABEL maintainer="Piotr Kośka helppointit@gmail.com"
# home dns.
#RUN echo -e "https://dl-cdn.alpinelinux.org/alpine/latest-stable/main\nhttps://dl-cdn.alpinelinux.org/alpine/latest-stable/community" > /etc/apk/repositories
RUN apk update
RUN apk add --no-cache bind bash
COPY bind /etc/bind
RUN export VALUE_HELPPOINTIT=$(date '+%j%H%M'); sed -i "s/19860415222343/$VALUE_HELPPOINTIT/g" /etc/bind/zones/db.koska.in
RUN export VALUE_HELPPOINTIT=$(date '+%j%H%M'); sed -i "s/19860415222343/$VALUE_HELPPOINTIT/g" /etc/bind/zones/db.strefakursow.in
RUN mkdir -p /var/log/bind/
RUN touch /var/log/bind/rpz.log
RUN chmod 777 /var/log/bind/rpz.log

EXPOSE 53/tcp 53/udp
CMD ["/usr/sbin/named", "-f", "-g"]