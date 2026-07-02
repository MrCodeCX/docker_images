FROM ros:jazzy-ros-base

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# ROS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        ros-jazzy-desktop-full=0.11.0-1* \
        ros-jazzy-simulation=0.11.0-1* \
        ros-jazzy-perception=0.11.0-1* && \
    rm -rf /var/lib/apt/lists/*

# Dev packages + sudo setup (reuse the base image's default "ubuntu" user)
RUN apt-get update && apt-get install -y --no-install-recommends sudo zsh git fzf wget nano curl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

# oh-my-zsh setup + ROS environment
COPY --chown=ubuntu:ubuntu scripts/setup_zsh.sh /tmp/setup_zsh.sh
RUN sh /tmp/setup_zsh.sh && rm /tmp/setup_zsh.sh && \
    echo 'source /opt/ros/jazzy/setup.zsh' >> ~/.zshrc

WORKDIR /workspace
COPY --chown=ubuntu:ubuntu scripts/setup_ai_tools.sh /tmp/setup_ai_tools.sh

CMD ["/bin/zsh"]
