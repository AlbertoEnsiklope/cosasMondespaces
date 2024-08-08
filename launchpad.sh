#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Intentar corregir problemas de paquetes retenidos
sudo apt-get --fix-broken install -y

# Instalar containerd
sudo apt-get install -y containerd

# Instalar Docker
sudo apt-get install -y docker.io

# Instalar Docker Compose
sudo apt-get install -y docker-compose

# Crear el directorio de configuración si no existe
mkdir -p ./webtop_config

# Navegar al directorio donde se encuentra el archivo docker-party.yml
cd "$(dirname "$0")"

# Ejecutar Docker Compose
sudo docker-compose -f docker-party.yml up -d
