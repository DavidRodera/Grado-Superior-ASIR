---
title:   "Guía de la Plantilla"

author: "David Rodera"
subject: "Documentación"
date: "2024–2025"
---

# Estructura del YAML

Todo archivo `.md` debe empezar con un bloque YAML. Los cuatro campos son obligatorios:

```
---
title:   "Nombre del Proyecto"
author:  "David Rodera"
subject: "Nombre de la Asignatura"
date:    "Curso 2024–2025"
---
```

- **title** → texto grande en la portada (en mayúsculas automáticamente)
- **subject** → aparece girado en la franja derecha de la portada y en la cabecera de cada página
- **author** → esquina inferior izquierda de la portada
- **date** → solo se usa en los metadatos del PDF, no aparece visualmente

# Títulos y secciones

Usa la jerarquía estándar de Markdown. Cada nivel tiene una tipografía distinta:

```
# Sección principal          ← Montserrat ExtraBold + línea decorativa
## Subsección                ← Cabin, gris medio
### Sub-subsección           ← Cabin cursiva, gris claro
```

Las secciones principales (`#`) generan entradas en negrita en el índice.
Las subsecciones (`##`) aparecen indentadas en el índice.

# Tablas

Las tablas Markdown estándar se renderizan con cabecera oscura y filas alternas:

```
| Columna A | Columna B | Columna C |
|-----------|-----------|-----------|
| Valor 1   | Valor 2   | Valor 3   |
| Valor 4   | Valor 5   | Valor 6   |
```

# Bloques de código

## SQL / MySQL

Usa ` ```sql ` o ` ```mysql `. El resultado imita MySQL Workbench: fondo gris claro,
palabras clave en azul, strings en rojo, comentarios en gris.

```sql
-- Crear tabla de ejemplo
CREATE TABLE usuarios (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email  VARCHAR(150) UNIQUE
);

SELECT * FROM usuarios WHERE id = 1;
UPDATE usuarios SET email = 'nuevo@mail.com' WHERE id = 1;
```

## Terminal / Bash

Usa ` ```bash `, ` ```shell ` o ` ```terminal `. Fondo negro, texto verde.

```bash
davidrodera@PC-DAROVA:~/Proyecto$ ls -la
davidrodera@PC-DAROVA:~/Proyecto$ ./generar_pdf.sh apuntes.md
```

## Otros lenguajes

Para Python, JavaScript, HTML, etc., usa el nombre del lenguaje normalmente.
El fondo será gris claro con resaltado básico.

```python
def saludar(nombre):
    return f"Hola, {nombre}"

print(saludar("David"))
```

# Imágenes

## Imagen estándar (sin sombra)

```
![Descripción de la imagen](ruta/imagen.png)
```

## Imagen con sombra suave (recomendado)

Usa el comando LaTeX directamente en el `.md`:

```
\imagen[width=0.8\textwidth]{ruta/imagen.png}
\imagen[width=\textwidth]{ruta/imagen.png}
\imagen[width=5cm]{ruta/imagen.png}
```

La sombra es difuminada hacia la derecha e inferior, ligera (18% opacidad).

# Texto con formato

El formato estándar de Markdown funciona normalmente:

```
**negrita**        → Open Sans Semibold
*cursiva*          → Open Sans Italic
`código inline`    → DejaVu Sans Mono sobre fondo gris
```

### Bloques de aviso (Callouts)

::: note
Esta es una nota informativa estándar. Úsala para aclaraciones que no requieren atención inmediata.
:::

::: tip
¡Consejo rápido! Puedes usar este bloque para trucos o mejores prácticas que ayuden al lector.
:::

::: warning
Atención: Este bloque sirve para resaltar errores comunes o precauciones críticas.
:::

::: link
[Visitar el sitio web](https://google.com)
Este bloque se usa para enlaces destacados. Los enlaces son de color azul y clicables (se resaltan automáticamente en azul).
:::

## Generar el PDF


```bash
# Desde el directorio donde está el .md:
./generar_pdf.sh mi_archivo.md

# Sin índice:
./generar_pdf.sh mi_archivo.md --sin-indice
```

El script hace dos compilaciones automáticamente para que los
números de página del índice sean correctos.

# Archivos de la plantilla

La estructura del proyecto está organizada para separar los scripts de la lógica de la plantilla:

```text
/
├── generar_pdf.sh       ← script principal (ejecutar esto)
├── extraer_contenido.sh ← para pasar PDFs antiguos a Markdown
└── PLANTILLA/           ← carpeta con los recursos de diseño
    ├── header.tex           ← estilos, tipografías, colores
    ├── plantilla_custom.tex ← plantilla base de Pandoc
    ├── filtro_portada.lua   ← genera la portada y el índice
    ├── filtro_codigo.lua    ← aplica estilos a bloques de código
    └── filtro_notas.lua     ← procesa los callouts (notas, tips...)
```

# Dependencias (instalar una vez)

```bash
sudo apt install \
  pandoc \
  poppler-utils \
  texlive-xetex \
  texlive-latex-extra \
  texlive-latex-recommended \
  texlive-fonts-recommended \
  texlive-lang-spanish \
  fonts-open-sans \
  fonts-montserrat \
  fonts-cabin \
  fonts-dejavu
```
