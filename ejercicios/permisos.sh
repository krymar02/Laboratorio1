#!/bin/bash

# Paso 1: Verificar que se haya proporcionado un archivo como argumento
if [ $# -ne 1 ]; then
    echo "Error: Debe proporcionar un archivo como argumento."
    exit 1
fi

archivo="$1"

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo '$archivo' no existe."
    exit 1
fi

# a) Obtener los permisos del archivo
permisos=$(stat -c "%A" "$archivo")

# b) Definir la función para desglosar los permisos
get_permissions_verbose() {
    local perm_string="$1"
    
    # Extraer los permisos del usuario, grupo y otros
    usuario=${perm_string:0:3}
    grupo=${perm_string:3:3}
    otros=${perm_string:6:3}
    
    # c) Interpretar los permisos y mostrarlos
    interpretar_permisos "$usuario" "Usuario"
    interpretar_permisos "$grupo" "Grupo"
    interpretar_permisos "$otros" "Otros"
}

interpretar_permisos() {
    local perm_string="$1"
    local tipo="$2"
    
    echo "Permisos de $tipo:"
    
    # Verificar si tiene permiso de lectura
    if [ "${perm_string:0:1}" == "r" ]; then
        echo "- Lectura"
    else
        echo "- Sin Lectura"
    fi
    
    # Verificar si tiene permiso de escritura
    if [ "${perm_string:1:1}" == "w" ]; then
        echo "- Escritura"
    else
        echo "- Sin Escritura"
    fi
    
    # Verificar si tiene permiso de ejecución
    if [ "${perm_string:2:1}" == "x" ]; then
        echo "- Ejecución"
    else
        echo "- Sin Ejecución"
    fi
}

# Llamar a la función para mostrar los permisos de manera detallada
get_permissions_verbose "$permisos"
