FROM pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup + create user (dev)
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -u 1000 -s /bin/zsh dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

# oh-my-zsh setup
COPY --chown=dev:dev scripts/setup_zsh_debian.sh /tmp/setup_zsh_debian.sh
RUN sh /tmp/setup_zsh_debian.sh && rm /tmp/setup_zsh_debian.sh

WORKDIR /workspace
COPY --chown=dev:dev scripts/setup_ai_tools.sh /tmp/setup_ai_tools.sh

CMD ["/bin/zsh"]
