#!/bin/bash

# Permitir que root ejecute cualquier comando sin necesidad de contraseña
echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Crear alias para comandos comunes
echo "alias ls='ls --color=auto'" >> /root/.bashrc
echo "alias ll='ls -alF'" >> /root/.bashrc
echo "alias la='ls -A'" >> /root/.bashrc
echo "alias l='ls -CF'" >> /root/.bashrc

# Copiar archivos de configuración del usuario normal a root
cp /home/franco/.bashrc /root/
cp /home/franco/.profile /root/

# Cambiar permisos de directorios y archivos para que root tenga acceso completo
chmod -R 755 /home/franco
chown -R root:root /home/franco

echo "Configuración completada. Root ahora tiene acceso completo sin restricciones."
