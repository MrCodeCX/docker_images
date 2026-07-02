FROM ubuntu:noble

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

# oh-my-zsh setup
COPY --chown=ubuntu:ubuntu scripts/setup_zsh.sh /tmp/setup_zsh.sh
RUN sh /tmp/setup_zsh.sh && rm /tmp/setup_zsh.sh

WORKDIR /workspace
COPY --chown=node:node scripts/setup_ai_tools.sh ./setup_ai_tools.sh

CMD ["/bin/zsh"]
