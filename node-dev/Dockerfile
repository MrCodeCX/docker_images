FROM node:24

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER node

# oh-my-zsh setup
COPY --chown=node:node scripts/setup_zsh_debian.sh /tmp/setup_zsh_debian.sh
RUN sh /tmp/setup_zsh_debian.sh && rm /tmp/setup_zsh_debian.sh

WORKDIR /workspace
COPY --chown=node:node scripts/setup_ai_tools.sh /tmp/setup_ai_tools.sh

CMD ["/bin/zsh"]
