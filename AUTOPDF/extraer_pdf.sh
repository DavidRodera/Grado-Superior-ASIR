#!/bin/bash
# ─────────────────────────────────────────────────────────────────
#  extraer_pdf.sh — Extrae texto a .txt y capturas a IMG/imgN.png
# ─────────────────────────────────────────────────────────────────

set -e

VERDE='\033[0;32m'
ROJO='\033[0;31m'
AZUL='\033[0;34m'
NC='\033[0m'

# Verificar dependencias (poppler-utils)
if ! command -v pdftotext &> /dev/null || ! command -v pdfimages &> /dev/null; then
  echo -e "${ROJO}Error: Faltan las herramientas 'pdftotext' o 'pdfimages'.${NC}"
  echo -e "${AZUL}Instálalas ejecutando: sudo apt install poppler-utils${NC}"
  exit 1
fi

# Comprobar si se indicó un archivo PDF
if [ -z "$1" ]; then
  echo -e "${ROJO}Uso: $0 <archivo.pdf>${NC}"
  echo -e "${AZUL}Ejemplo: $0 documento.pdf${NC}"
  exit 1
fi

PDF_FILE="$1"

if [ ! -f "$PDF_FILE" ]; then
  echo -e "${ROJO}Error: No se encuentra el archivo '$PDF_FILE'.${NC}"
  exit 1
fi

# Obtener nombre base sin extensión
NOMBRE="${PDF_FILE%.pdf}"
TXT_FILE="${NOMBRE}.txt"
IMG_DIR="IMG"

echo -e "${AZUL}📄 Procesando PDF: $PDF_FILE${NC}"

# 1. Extraer texto a archivo .txt
echo -e "${AZUL}⚙  Extrayendo texto a '${TXT_FILE}'...${NC}"
pdftotext "$PDF_FILE" "$TXT_FILE"
echo -e "${VERDE}✔ Texto extraído correctamente en '${TXT_FILE}'.${NC}"

# 2. Crear carpeta IMG si no existe
mkdir -p "$IMG_DIR"

# 3. Extraer imágenes/capturas
echo -e "${AZUL}⚙  Extrayendo imágenes a la carpeta '${IMG_DIR}/'...${NC}"
pdfimages -png "$PDF_FILE" "${IMG_DIR}/temp_img"

# 4. Renombrar imágenes extraídas a imgN.png
n=1
for img in "${IMG_DIR}"/temp_img-*.png; do
  [ -e "$img" ] || continue
  # Renombrar secuencialmente
  mv "$img" "${IMG_DIR}/img${n}.png"
  n=$((n + 1))
done

TOTAL_IMG=$((n - 1))
if [ $TOTAL_IMG -gt 0 ]; then
  echo -e "${VERDE}✔ Se han extraído y renombrado $TOTAL_IMG imágenes en '${IMG_DIR}/' (img1.png a img${TOTAL_IMG}.png).${NC}"
else
  echo -e "${AZUL}ℹ No se encontraron imágenes incrustadas en este PDF.${NC}"
fi

echo -e "${VERDE}🎉 ¡Proceso completado con éxito!${NC}"
