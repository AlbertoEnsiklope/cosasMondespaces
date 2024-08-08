#!/bin/bash

# Actualizar el sistema
sudo apt-get update

# Instalar Docker
sudo apt-get install -y docker.io

# Instalar Docker Compose
sudo apt-get install -y docker-compose

# Crear el directorio de configuración si no existe
mkdir -p ./webtop_config

# Ejecutar Docker Compose
sudo docker-compose up -d
