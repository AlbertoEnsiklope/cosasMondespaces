#!/bin/bash

# Variables
NON_ROOT_USER="automatic"
DESKTOP_PASSWORD="vscode"
INSTALL_WEB_CLIENT="true"
VNC_PORT="5901"
WEB_PORT="6080"
SHM_SIZE="1g"
VNC_RESOLUTION="1280x720x16"

# Crear directorio para scripts si no existe
mkdir -p .devcontainer/library-scripts

# Descargar el script desktop-lite-debian.sh
cat << 'EOF' > .devcontainer/library-scripts/desktop-lite-debian.sh
# Aquí va el contenido del script desktop-lite-debian.sh
EOF

# Crear Dockerfile
cat << 'EOF' > .devcontainer/Dockerfile
FROM ubuntu:20.04

# Copiar el script de instalación
COPY library-scripts/desktop-lite-debian.sh /tmp/library-scripts/

# Ejecutar el script de instalación
RUN apt-get update && bash /tmp/library-scripts/desktop-lite-debian.sh

# Configurar variables de entorno
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:" \
    VNC_RESOLUTION="${VNC_RESOLUTION}" \
    VNC_DPI="96" \
    VNC_PORT="${VNC_PORT}" \
    NOVNC_PORT="${WEB_PORT}" \
    DISPLAY=":1" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

# Configurar el punto de entrada y el comando por defecto
ENTRYPOINT ["/usr/local/share/desktop-init.sh"]
CMD ["sleep", "infinity"]

# Instalar Firefox ESR
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y firefox-esr

# Instalar Google Chrome
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && curl -sSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/chrome.deb \
    && apt-get -y install /tmp/chrome.deb
EOF

# Crear devcontainer.json
cat << EOF > .devcontainer/devcontainer.json
{
  "runArgs": ["--init", "--shm-size=${SHM_SIZE}"],
  "forwardPorts": [${WEB_PORT}, ${VNC_PORT}],
  "overrideCommand": false,
  "features": {
    "desktop-lite": {
      "password": "${DESKTOP_PASSWORD}",
      "webPort": "${WEB_PORT}",
      "vncPort": "${VNC_PORT}"
    }
  }
}
EOF

# Mensaje final
echo "Configuración completada. Reconstruye tu contenedor para aplicar los cambios."
