# Docker Images

Development container images I use daily, each based on a common OS/runtime with `zsh` + `oh-my-zsh` preconfigured for a faster, autocomplete-friendly shell.

## Images

| Image | Base |
|---|---|
| `arch-dev` | `archlinux:latest` |
| `esp-idf-dev` | `espressif/idf:release-v6.0` |
| `node-dev` | `node:24` |
| `pio-dev` | `python:3.12-slim` |
| `pytorch-dev` | `pytorch/pytorch:2.9.1-cuda12.8-cudnn9-runtime` |
| `ros-dev` | `ros:jazzy-ros-base` |

Every image shares `scripts/setup_zsh.sh`, which installs and configures `oh-my-zsh` with the following plugins:

- `git`, `zsh-autosuggestions`, `zsh-completions`, `fzf-tab`

Default theme is `af-magic`. To change it, pass a different theme name where `setup_zsh.sh` is invoked in the target Dockerfile (e.g. `RUN sh /tmp/setup_zsh.sh eastwind`).

All images except `arch-dev` also bake in Claude Code + Codex CLI, and ship with a `docker-compose.yml` + `.env` + `setup.sh` already configured for persistent AI-tool sessions (see below). `arch-dev` is kept intentionally minimal.

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

## Running an Image

Each image's `docker-compose.yml` + `.env` already configures the right volumes, user, and (where relevant) GPU/X11/USB passthrough — no manual `docker run`/`docker create` flags needed.

1. Set `WORKSPACE` in `<image>/.env` to the host folder to mount at `/workspace`.
2. Run `<image>/setup.sh` once, before the first `docker compose up` — it safely creates `.docker-data/` (and its contents) so Docker doesn't create them as root-owned on first mount. Not needed for `arch-dev`.
3. `docker compose -f <image>/docker-compose.yml up -d`

## Persisted State (`.docker-data/`)

Bind-mounted from `$WORKSPACE` into the container's home (`$CONTAINER_HOME`, set per-image in `.env`), so recreating the container doesn't lose:

- `.claude`, `.claude.json` — Claude Code session/config
- `.codex-data`, via `CODEX_HOME` — Codex CLI auth/session/config (kept separate from the image's own `~/.codex`, where the installed binary lives)
- `.vscode-server` — VS Code Server + installed extensions, when connecting via Dev Containers/Remote

## Building an Image

```shell
docker compose -f <image>/docker-compose.yml build
```

## License

See [LICENSE](./LICENSE).
