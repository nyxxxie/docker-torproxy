FROM alpine:3.7

EXPOSE 9050

RUN apk --update add tor

COPY ./torrc /etc/tor/torrc

ENTRYPOINT [ "tor", "-f", "/etc/tor/torrc" ]
