FROM alpine:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup + create user (root)
RUN apk add --no-cache sudo zsh git fzf wget nano curl && \
    adduser -D -u 1000 dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

# oh-my-zsh setup
COPY --chown=dev:dev scripts/setup_zsh_alpine.sh /tmp/setup_zsh_alpine.sh
RUN sh /tmp/setup_zsh_alpine.sh && rm /tmp/setup_zsh_alpine.sh

WORKDIR /workspace
CMD ["/bin/zsh"]
