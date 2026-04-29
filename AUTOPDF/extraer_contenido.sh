#!/bin/bash

# Comprobar si se ha pasado un archivo como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 archivo.pdf"
    exit 1
fi

FILE="$1"
FILENAME=$(basename -- "$FILE")
BASENAME="${FILENAME%.*}"
IMG_DIR="${BASENAME}_images"
TEXT_FILE="${BASENAME}_text.md"

# Comprobar si el archivo existe
if [ ! -f "$FILE" ]; then
    echo "Error: El archivo '$FILE' no existe."
    exit 1
fi

echo "Procesando $FILE..."

# 1. Crear carpeta para imágenes y extraerlas
echo "Extraiendo imágenes en la carpeta $IMG_DIR..."
mkdir -p "$IMG_DIR"
pdfimages -png "$FILE" "$IMG_DIR/img"

# 2. Extraer texto y guardarlo en .md
echo "Extrayendo texto en $TEXT_FILE..."
pdftotext "$FILE" "$TEXT_FILE"

echo "¡Hecho!"
echo "- Imágenes en: $IMG_DIR/"
echo "- Texto en: $TEXT_FILE"
