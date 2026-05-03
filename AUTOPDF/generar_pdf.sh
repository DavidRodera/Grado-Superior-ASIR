#!/bin/bash
# ─────────────────────────────────────────────────────────────────
#  generar_pdf.sh — Convierte .md a PDF con plantilla David Rodera
# ─────────────────────────────────────────────────────────────────

set -e

VERDE='\033[0;32m'
ROJO='\033[0;31m'
AZUL='\033[0;34m'
NC='\033[0m'

if [ -z "$1" ]; then
  echo -e "${ROJO}Error: debes indicar un archivo .md${NC}"
  exit 1
fi

ARCHIVO_MD="$1"
NOMBRE="${ARCHIVO_MD%.md}"
ARCHIVO_PDF="${NOMBRE}.pdf"
DIR="$(cd "$(dirname "$0")" && pwd)"
PLANTILLA_DIR="${DIR}/PLANTILLA"

HEADER="${PLANTILLA_DIR}/header.tex"
PLANTILLA="${PLANTILLA_DIR}/plantilla_custom.tex"
FILTRO_COD="${PLANTILLA_DIR}/filtro_codigo.lua"
FILTRO_PORT="${PLANTILLA_DIR}/filtro_portada.lua"
FILTRO_NOTAS="${PLANTILLA_DIR}/filtro_notas.lua"
FILTRO_TABLAS="${PLANTILLA_DIR}/filtro_tablas.lua"

if [ ! -f "$ARCHIVO_MD" ]; then
  echo -e "${ROJO}Error: no se encuentra '$ARCHIVO_MD'${NC}"; exit 1
fi

# Pasar flag --sin-indice al filtro vía variable de entorno
export SIN_INDICE=""
[ "$2" == "--sin-indice" ] && export SIN_INDICE="1"

PANDOC_ARGS=(
  --pdf-engine=xelatex
  --template="$PLANTILLA"
  --include-in-header="$HEADER"
  --lua-filter="$FILTRO_PORT"
  --lua-filter="$FILTRO_COD"
  --lua-filter="$FILTRO_NOTAS"
  --lua-filter="$FILTRO_TABLAS"
  -V mainfont="Open Sans"
  -V sansfont="Open Sans"
  -V monofont="DejaVu Sans Mono"
  -V colorlinks=true
)

echo -e "${AZUL}⚙  Generando: ${ARCHIVO_PDF}...${NC}"

# Dos pasadas para que el índice tenga los números de página correctos
pandoc "$ARCHIVO_MD" "${PANDOC_ARGS[@]}" -o "$ARCHIVO_PDF"
pandoc "$ARCHIVO_MD" "${PANDOC_ARGS[@]}" -o "$ARCHIVO_PDF"

echo -e "${VERDE}✅ PDF generado: ${ARCHIVO_PDF}${NC}"
