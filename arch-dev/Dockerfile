FROM archlinux:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Packages + sudo setup + create user (root)
RUN pacman-key --init && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo zsh git fzf wget nano curl && \
    rm -rf /var/cache/pacman/pkg/* && \
    useradd -m -u 1000 dev && \
    echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dev

# oh-my-zsh setup
COPY --chown=dev:dev scripts/setup_zsh.sh /tmp/setup_zsh.sh
RUN sh /tmp/setup_zsh.sh && rm /tmp/setup_zsh.sh

WORKDIR /workspace
CMD ["/bin/zsh"]
