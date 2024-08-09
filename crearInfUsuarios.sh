#!/bin/bash

# Función para generar nombres completos inventados relacionados con Corea
generate_random_name() {
    first_names=("Jin" "Hyeon" "Ji" "Min" "Soo" "Hyun" "Joon" "Hana" "Yuna" "Seok" "Hye" "Eun" "Mi" "Young" "Sun" "Jae" "Kyung" "Hyo" "In" "Sang" "Dong" "Hwan" "Jong" "Kwang" "Nam" "Suk" "Woo" "Yong" "Chul" "Geun" "Hee" "Ho" "Il" "Jin" "Ki" "Myung" "Seung" "Tae" "Won" "Yoon" "Ah" "Bo" "Chae" "Da" "Eun" "Ga" "Ha" "Ji" "Kyung" "Mi" "Na" "Ra" "Seo" "Ye" "Yu")
    last_names=("Kim" "Lee" "Park" "Choi" "Jung" "Kang" "Cho" "Yoon" "Jang" "Lim" "Han" "Oh" "Seo" "Shin" "Kwon" "Hwang" "Ahn" "Song" "Jeon" "Hong" "Yoo" "Moon" "Bae" "Ko" "Nam" "Joo" "Baek" "Chun" "Jin" "Koo" "Noh" "Ryu" "Shim" "Suh" "Yoon" "Chang" "Chung" "Huh" "Joo" "Koh" "Kwon" "Min" "Nam" "Roh" "Shin" "Sung" "Yang" "Yoo" "Yun")

    first_name=${first_names[$RANDOM % ${#first_names[@]}]}
    last_name=${last_names[$RANDOM % ${#last_names[@]}]}
    
    echo "$first_name $last_name"
}

# Solicitar al usuario el número de usuarios a crear
read -p "Introduce el número de usuarios a crear (0-999999): " num_users

# Validar que el número esté en el rango permitido
if [[ $num_users -lt 0 || $num_users -gt 999999 ]]; then
    echo "Número inválido. Por favor, introduce un número entre 0 y 999999."
    exit 1
fi

# Preguntar si los usuarios deben ser añadidos al grupo sudo
read -p "¿Quieres añadir a los usuarios al grupo sudo? (s/n): " add_to_sudo

# Contraseña común para todos los usuarios
common_password="TuContraseñaSegura"

# Crear los usuarios
for ((i=1; i<=num_users; i++)); do
    username="wylm$i"
    full_name=$(generate_random_name)
    
    # Crear el usuario con el nombre completo inventado y su directorio en /home
    useradd -m -c "$full_name" -d "/home/$username" -s /bin/bash "$username"
    
    # Asignar la contraseña común
    echo "$username:$common_password" | chpasswd
    
    # Añadir al grupo sudo si se seleccionó
    if [[ $add_to_sudo == "s" ]]; then
        usermod -aG sudo "$username"
    fi
    
    # Configurar archivos de inicio
    cp /etc/skel/.bashrc /home/$username/
    cp /etc/skel/.profile /home/$username/
    chown $username:$username /home/$username/.bashrc /home/$username/.profile
    
    # Mostrar el nombre de usuario y la contraseña
    echo "Nombre completo: $full_name, Contraseña: $common_password, Usuario: $username"
done

echo "Todos los usuarios han sido creados. Total de usuarios creados: $num_users"
echo "Ver todos los usuarios:"
echo "cut -d: -f1 /etc/passwd"
echo "Cambio de usuario: su - nombre_de_usuario"
