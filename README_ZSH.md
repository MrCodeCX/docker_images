### Imagen de <BASE> con OH-MY-ZSH

Imagen base <BASE>, el script setup_zsh_<BASE>.sh se encarga de toda la instalacion y configuracion de oh-my-zsh.

---

### Plugins

Plugins orientados a una shell inteligente, con intelliscence.

- Lista: git zsh-autosuggestions zsh-completions fzf-tab

---

### Paquetes (Instalados por Setup)

- **Dependencias de oh-my-zsh**: zsh git wget
s
- **Dependencias de los plugins**: fzf

- **Paquetes de utilidad**: nano

### Tema

Af-magic por defecto, si deseas cambiarlo

- Clona este repositorio

- Modifica en Dockerfile la linea ARG ZSH_THEME="af-magic"

- Construye la imagen (desde la carpeta <IMAGE>): docker build -t <USER>/<IMAGE>:latest . 