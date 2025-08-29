FROM debian:trixie

RUN apt update
RUN apt install openssh-server -y

WORKDIR /config

RUN useradd jump -G users --uid 424242 -s /usr/bin/bash -d /config
RUN chown 424242:424242 /config

COPY --chown=jump resources/ .
RUN chmod +x ./entrypoint.sh

USER 424242

ENTRYPOINT ["/config/entrypoint.sh"]