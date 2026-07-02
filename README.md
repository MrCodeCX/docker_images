# Docker Images

Development container images I use daily, each based on a common OS/runtime with `zsh` + `oh-my-zsh` preconfigured for a faster, autocomplete-friendly shell.

## Images

| Image | Base |
|---|---|
| `alpine-dev` | `alpine:latest` |
| `arch-dev` | `archlinux:latest` |
| `node-dev` | `node:24` |
| `pytorch-dev` | `pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime` |
| `ros-dev` | `ros:jazzy-ros-base` |
| `ubuntu-dev` | `ubuntu:noble` |

Each image includes a `setup_zsh_<base>.sh` script (see `scripts/`) that installs and configures `oh-my-zsh` with the following plugins:

- `git`, `zsh-autosuggestions`, `zsh-completions`, `fzf-tab`

Default theme is `af-magic`. To change it, edit `ARG ZSH_THEME` in the target Dockerfile before building.

## Installation

Install the Docker CLI following the ["Install using the apt repository"](https://docs.docker.com/engine/install/ubuntu/) section of the official docs.

To run Docker as a non-root user:

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
```

For VS Code integration, install:

- **Container Tools** — Dockerfile intellisense and management GUI.
- **Dev Containers** — remote development inside containers.

## Building an Image

```shell
docker build -t <user>/<image>:latest ./<image>
```

## Container Runtime Options

**GPU access**

```shell
docker create -i -t --gpus all --name <name> <image>
```

**Full GPU access (compute + OpenGL rendering, e.g. Gazebo)**

```shell
docker create -i -t \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  --name <name> <image>
```

On hybrid-graphics hosts, force the NVIDIA GPU for rendering by adding to `~/.zshrc`:

```shell
echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> "${HOME}/.zshrc"
echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> "${HOME}/.zshrc"
```

**X11 (GUI) access**

```shell
docker create -i -t \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name <name> <image>
```

Grant Docker access to the X server (required after every host session restart):

```shell
xhost +local:docker   # grant
xhost -local:docker   # revoke
```

**Custom volume**

```shell
docker create -i -t -v <src>:/workspace --name <name> <image>
```

**Full setup (GPU + X11 + volume)**

```shell
docker create -i -t \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v <src>:/workspace \
  --name <name> <image>
```

```shell
echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> "${HOME}/.zshrc"
echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> "${HOME}/.zshrc"
xhost +local:docker
```

## License

See [LICENSE](./LICENSE).
