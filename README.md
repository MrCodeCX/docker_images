### DOCKER IMAGES

Imagenes de Docker que suelo usar cuando trabajo con contenedores.

Encuentro que zsh mejora mi productividad, sobre todo con los plugins de oh-my-zsh para autocompletado e intellisence. Es por ello que casi siempre incluyo en los contenedores un **setup script** que se encarga de instalarlo con todas mis configuraciones personales.

---

#### INSTALLATION

---

Para instalar docker-cli, revisar la seccion "Install using the apt repository":

- https://docs.docker.com/engine/install/ubuntu/

Para usar docker desde $USER sin permisos de root, ejecutar:

```shell
sudo groupadd docker             # Crea el grupo docker
sudo usermod -aG docker $USER    # Agrega el usuario al grupo docker
```

Para usar docker con VSCODE, instalar las extensiones:

- **CONTAINER TOOLS**: Intellisence en DockerFile, y gui de administracion.

- **DEV CONTAINERS**: VSCode remoto, extensiones separadas, etc.

---

#### IMPORTANT CONTAINER SETTINGS

---

#### Para dar Acceso a Interfaz Grafica (X11)

```shell
docker create -i -t \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--name <name> <image>
```

Darle permisos a docker sobre xhost (debe hacerse cada vez que se cierre la sesion del host):

```shell
xhost +local:docker   # agregar docker
xhost -local:docker   # quitar docker
```

---

#### Para dar Acceso a GPU (Normal)

```shell
docker create -i -t \
--gpus all \
--name <name> <image>
```

---

#### Para dar Acceso Completo a GPU (compute, graphics, opengl, etc)

- **Variables a exportar durante la creacion del contenedor**: 
  
  Normalmente le otorga a los contenedores con acceso a gpu capacidades de computo y utilidad, pero, si se desa usar aplicaciones que usen renderizado grafico (opengl) como gazebo, etc, para ello es:
  
  - **-e NVIDIA_DRIVER_CAPABILITIES=all**

- **Variables a exportar en la sesion (sourcear a .zshrc)**: 
  
  - Desde un host con grafica integrada la libreria de renderizado puede acabar usando la grafica integrada en vez de la dedicada, para ello se especifica que se use la grafica nvidia con:
  
  ```shell
  echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> "${HOMER}/.zshrc"
  ```
  
  - Para especificarle a opengl que use la grafica nvidia:
  
  ```shell
  echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> "${HOMER}/.zshrc"
  ```

- **Resumen**
  
  Crear el contenedor con:
  
  ```shell
  docker create -i -t \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  --name <name> <image>
  ```
  
  Una vez creado ejecutar:
  
  ```shell
  echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> "${HOME}/.zshrc"
  echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> "${HOME}/.zshrc"
  ```

---

#### Para Crear un Volumen Personalizado

```shell
docker create -i -t \
-v <src>:/workspace \
--name <name> <image>
```

---

#### Para una Configuracion General Completa de Permisos (Interfaz Grafica, Acceso Completo a GPU, Volumen Personalizado)

Crear contenedor:

```shell
docker create -i -t \
--gpus all \
-e NVIDIA_DRIVER_CAPABILITIES=all \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v <src>:/workspace \
--name <name> <image>
```

Una vez creado ejecutar:

```shell
echo "export __NV_PRIME_RENDER_OFFLOAD=1" >> "${HOME}/.zshrc"
echo "export __GLX_VENDOR_LIBRARY_NAME=nvidia" >> "${HOME}/.zshrc"
```

Darle permisos a docker sobre xhost (debe hacerse cada vez que se cierre la sesion del host):

```shell
xhost +local:docker
```