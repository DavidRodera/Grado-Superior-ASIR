---
tipo: "GUÍA DE REFERENCIA"
title: "Guía completa de la Plantilla LaTeX & Markdown"
author: "David Rodera"
subject: "Documentación y Uso"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Guía de referencia · Plantilla ASIR"
---

# 1. Primeros pasos y Estructura YAML

Todo documento `.md` debe comenzar con un bloque YAML para configurar la portada, metadatos y el índice automático:

```yaml
---
tipo: "GUÍA DE ESTUDIO"
title: "Título principal del documento"
author: "Subtítulo o descripción breve"
subject: "Asignatura (ej. Implantación de Sistemas Operativos)"
curso: "CFGS ASIR"
footer: "Pie de página personalizado · ASIR"
---
```

- **tipo**: Categoría del documento en la parte superior de la portada (ej. "GUÍA DE ESTUDIO", "PRÁCTICA", "RESUMEN").
- **title**: Título principal (enorme, color azul profundo).
- **author**: Subtítulo o nombre del autor.
- **subject**: Asignatura.
- **curso**: Curso o ciclo formativo.
- **footer**: Texto que aparece en el pie de página de todas las páginas junto al número de página.

# 2. Generar el PDF y Opciones de Compilación

Para generar el PDF a partir de tu archivo Markdown, utiliza el script `generar_pdf.sh`:

```bash
# Compilación estándar (genera portada, índice y contenido)
./generar_pdf.sh tu_archivo.md

# Generar sin índice de contenidos (--sin-indice)
./generar_pdf.sh tu_archivo.md --sin-indice

# Generar solo el contenido (sin portada y sin índice) (--solo-contenido)
./generar_pdf.sh tu_archivo.md --solo-contenido
```

El script compila automáticamente dos veces para asegurar que los números de página del índice sean correctos.

# 3. Títulos y Secciones

Usa la jerarquía estándar de Markdown. Cada nivel tiene su tipografía y espaciado optimizado:

```markdown
# Sección principal (H1)     ← Montserrat Bold + línea decorativa inferior
## Subsección (H2)           ← Cabin, color Teal
### Sub-subsección (H3)      ← Cabin cursiva, gris cabecera
```

Las secciones (`#`) generan automáticamente entradas en negrita en el índice general.

# 4. Saltos de Página Manuales

Si en algún momento deseas forzar un salto de página exacto (por ejemplo, para separar temas importantes), puedes escribir en cualquier parte de tu Markdown:

```markdown
\newpage
```

o bien:

```markdown
\pagebreak
```

*(Nota: La plantilla también cuenta con protección automática para evitar títulos huérfanos y cortes indeseados en párrafos, bloques de código o imágenes).*

# 5. Estilos de Texto, Colores y Tipografías Inline

Puedes aplicar formato básico con Markdown estándar o utilizar comandos LaTeX para colores y estilos específicos:

```markdown
**negrita**        → Open Sans Semibold
*cursiva*          → Open Sans Italic
`código inline`    → Monoespaciado sobre fondo gris
```

### Texto con Colores Personalizados
Puedes destacar palabras o frases concretas usando el comando LaTeX `\textcolor{color}{texto}`:

```markdown
Esto es un texto normal y esto es \textcolor{emeraldGreen}{texto en verde esmeralda}.
```

Colores disponibles en la plantilla:
- `emeraldGreen` (Verde esmeralda)
- `azulProfundo` (Azul corporativo)
- `colorTeal` (Verde azulado)
- `darkBlue` (Azul oscuro)
- `grisCabecera` (Gris texto)

# 6. Imágenes y Rejillas (Grids)

## Imagen con sombra suave (Recomendado)
Usa el comando `\imagen` para añadir bordes y sombras difuminadas profesionales:

```markdown
\imagen[width=0.8\textwidth]{fotos/imagen.png}
\imagen[width=\linewidth]{fotos/imagen.png}
```

## Rejilla de Imágenes (Grid)
Organiza varias imágenes en columnas usando bloques `::: {.grid}`:

```markdown
::: {.grid cols=2}
![](fotos/img1.png)
![](fotos/img2.png)
:::
```

### Control de Columnas (Spans)
Haz que una imagen ocupe varias columnas con `{span=N}`:

```markdown
::: {.grid cols=2}
![](fotos/grande.png){span=2}
![](fotos/peque1.png)
![](fotos/peque2.png)
:::
```

# 7. Bloques de Aviso (Callouts)

Destaca información importante mediante contenedores estilizados:

```markdown
::: note
Nota informativa estándar para aclaraciones generales.
:::

::: tip
Consejo rápido o buenas prácticas recomendadas.
:::

::: warning
Advertencia sobre errores comunes o precauciones críticas.
:::

::: link
[Enlace destacado](https://google.com)
Bloque especial para enlaces web importantes.
:::
```

# 8. Tablas

Las tablas se escriben en formato estándar de Markdown. La plantilla incluye un sistema inteligente automatizado que gestiona:
- **Ancho equitativo**: Todas las columnas tienen exactamente el mismo tamaño, adaptándose al ancho de página.
- **Ajuste de texto automático**: Si introduces mucho texto en una celda, se ajustará y saltará de línea automáticamente.
- **Estilo automático**:
  - **Cabecera**: Fondo azul oscuro (`colorNota`) con texto en blanco y negrita.
  - **Filas alternas**: Alternancia elegante entre fondo blanco y azul claro (`bgNota`).
  - **Bordes y rejilla**: Bordes en color azul nota (`colorNota`) de `0.8pt`.
- **Tablas grandes**: Si la tabla tiene más de 5 columnas, el tamaño de la fuente se reduce ligeramente de forma automática para asegurar que encaje perfectamente en la página.

```markdown
| Columna A | Columna B | Columna C |
| :--- | :--- | :--- |
| Valor 1 con texto largo | Valor 2 | Valor 3 |
| Valor 4 | Valor 5 | Valor 6 |
```

# 9. Bloques de Código

La plantilla incluye soporte especializado para distintos tipos de código:

## 1. Terminal (Estilo Ubuntu)
Cualquier bloque con etiqueta ` ```terminal `, ` ```console ` o ` ```ubuntu ` generará automáticamente un recuadro oscuro con el fondo granate de Ubuntu (`#300A24`) e insertará de forma automática el prompt `usuario@PC-usuario:~$` (con el usuario en verde esmeralda, `~` en azul oscuro, y `:` y `$` en blanco).

```terminal
sudo apt update
sudo apt install apache2
systemctl status apache2
```

## 2. Bash Script
Para scripts de Bash (etiqueta ` ```bash ` o ` ```sh `), se activa un editor de texto en modo claro con resaltado de sintaxis (palabras clave en azul, variables en naranja, opciones en púrpura y comentarios en verde).

```bash
#!/bin/bash
# Script de ejemplo
usuario="admin"
if [ -d /home/$usuario ]; then
    echo "El usuario existe"
fi
```

## 3. SQL / MySQL
Usa ` ```sql ` o ` ```mysql ` para simular MySQL Workbench con resaltado específico (palabras clave en azul, strings en rojo).

```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
```

## 4. Otros Lenguajes (Python, JS, etc.)
Cualquier otro lenguaje se renderiza con fondo gris claro, marco sutil y el título del lenguaje centrado en su pestaña superior.

```python
def saludar(nombre):
    return f"Hola, {nombre}"
```

---

# 10. Estructura del Proyecto

```text
/
├── generar_pdf.sh       ← Script principal de compilación
├── guia_plantilla.md    ← Esta guía de referencia
└── PLANTILLA/           ← Recursos de diseño LaTeX y filtros Lua
    ├── header.tex           ← Estilos, tipografías, colores y cajas
    ├── plantilla_custom.tex ← Plantilla base de Pandoc
    ├── filtro_portada.lua   ← Portada e índice automático
    ├── filtro_codigo.lua    ← Procesamiento de bloques de código
    ├── filtro_notas.lua     ← Procesamiento de callouts
    ├── filtro_grid.lua      ← Gestión de rejillas de imágenes
    └── filtro_tablas.lua    ← Auto-ajuste, cabeceras y anchos de tabla
```
