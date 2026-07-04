FROM pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup + create user (dev)
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -u 1000 dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

# oh-my-zsh setup
COPY --chown=dev:dev scripts/setup_zsh.sh /tmp/setup_zsh.sh
RUN sh /tmp/setup_zsh.sh && rm /tmp/setup_zsh.sh

WORKDIR /workspace

ENV PATH="/home/dev/.local/bin:${PATH}"

# Installs claude code for the current user.
RUN curl -fsSL https://claude.ai/install.sh | bash

# Installs codex for the current user.
RUN curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh

CMD ["/bin/zsh"]
