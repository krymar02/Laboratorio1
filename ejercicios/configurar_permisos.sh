#!/bin/bash

# Paso 2a: Recibir nombres de usuario y grupo como argumentos
if [ $# -ne 2 ]; then
    echo "Error: Debe proporcionar el nombre de un nuevo usuario y el nombre de un grupo."
    exit 1
fi

nuevo_usuario="$1"
nuevo_grupo="$2"

# Comprobar si el usuario ya existe
if id "$nuevo_usuario" &>/dev/null; then
    echo "El usuario '$nuevo_usuario' ya existe."
else
    # Crear el nuevo usuario
    sudo useradd "$nuevo_usuario" -m
    echo "Usuario '$nuevo_usuario' creado."
fi

# Comprobar si el grupo ya existe
if grep -q "^$nuevo_grupo:" /etc/group; then
    echo "El grupo '$nuevo_grupo' ya existe."
else
    # Crear el nuevo grupo
    sudo groupadd "$nuevo_grupo"
    echo "Grupo '$nuevo_grupo' creado."
fi

# Agregar el usuario predeterminado y el nuevo usuario al grupo
sudo usermod -aG "$nuevo_grupo" "$USER"
sudo usermod -aG "$nuevo_grupo" "$nuevo_usuario"

# Cambiar los permisos del script anterior para que solo los miembros del grupo puedan ejecutarlo
chmod 750 permisos.sh

echo "Permisos configurados para el grupo '$nuevo_grupo'."
