#!/bin/bash

# Directorio raíz desde donde se ejecuta el script
root_dir=$1

# Archivo de salida donde se consolidará todo
output_file=$2

# Verificar si se proporcionó el directorio raíz y el archivo de salida
if [ -z "$root_dir" ] || [ -z "$output_file" ]; then
  echo "Uso: $0 <directorio_raiz> <archivo_salida>"
  exit 1
fi

# Crear o vaciar el archivo de salida si ya existe
> "$output_file"

# Función para recorrer los archivos
function process_directory() {
    local directory=$1

    # Recorrer todos los archivos y subdirectorios
    for file in "$directory"/*; do
        if [ -d "$file" ]; then
            # Si es un directorio, procesar recursivamente
            process_directory "$file"
        elif [ -f "$file" ]; then
            # Si es un archivo, agregar al archivo de salida
            echo "---" >> "$output_file"
            echo "$file" >> "$output_file"
            echo "---" >> "$output_file"
            cat "$file" >> "$output_file"
            echo "___" >> "$output_file"
        fi
    done
}

# Llamar a la función con el directorio raíz
process_directory "$root_dir"

echo "Archivo consolidado creado en: $output_file"
