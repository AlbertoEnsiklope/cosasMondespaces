#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Instalar Docker
sudo apt-get install -y docker.io

# Instalar Docker Compose
sudo apt-get install -y docker-compose

# Crear el directorio de configuración si no existe
mkdir -p ./webtop_config

# Navegar al directorio donde se encuentra el archivo docker-compose.yml
cd /ruta/a/tu/docker-compose

# Ejecutar Docker Compose
sudo docker-compose up -d
