FROM python:3.12-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup + create user (dev)
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -u 1000 -G dialout dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

# Installs platformio core for the current user.
RUN python3 -m pip install --user -U platformio

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
