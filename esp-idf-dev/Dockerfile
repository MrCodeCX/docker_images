FROM espressif/idf:release-v6.0

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Dev packages + sudo setup (reuse the base image's default "ubuntu" user, already in the dialout group)
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

# oh-my-zsh setup
COPY --chown=ubuntu:ubuntu scripts/setup_zsh.sh /tmp/setup_zsh.sh
RUN sh /tmp/setup_zsh.sh && rm /tmp/setup_zsh.sh

WORKDIR /workspace
COPY --chown=ubuntu:ubuntu scripts/setup_ai_tools.sh /tmp/setup_ai_tools.sh

CMD ["/bin/zsh"]
