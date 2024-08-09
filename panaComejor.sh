#!/bin/bash

# Actualizar los paquetes
sudo apt update -y

# Instalar XFCE4, VNC y otras herramientas
sudo apt install -y xfce4 xfce4-goodies novnc python3-websockify python3-numpy tightvncserver htop nano neofetch firefox gedit

# Generar un certificado SSL para noVNC sin interacción
openssl req -x509 -nodes -newkey rsa:3072 -keyout novnc.pem -out novnc.pem -days 3650 -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

# Generar una contraseña aleatoria solo con letras para VNC
VNCPASS=$(tr -dc A-Za-z </dev/urandom | head -c 12)
echo $VNCPASS | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Configurar VNC
USER=root vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

# Crear un nuevo archivo xstartup
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF

# Hacer el archivo ejecutable
chmod +x ~/.vnc/xstartup

# Iniciar VNC server con la contraseña generada
USER=root vncserver

# Iniciar websockify para noVNC
websockify -D --web=/usr/share/novnc/ --cert=/home/ubuntu/novnc.pem 6080 localhost:5901

# Mostrar la contraseña generada
echo "La contraseña generada para VNC es: $VNCPASS"
