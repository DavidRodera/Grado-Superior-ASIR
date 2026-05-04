# Guía de Uso: Rejilla de Imágenes (Estilo Grid)

Esta plantilla permite organizar imágenes en una rejilla flexible similar a CSS Grid usando bloques de Markdown.

## Uso Básico

Para crear una rejilla, utiliza un bloque `div` con la clase `.grid` y el atributo `cols` para indicar el número de columnas (por defecto son 2).

```markdown
::: {.grid cols=2}
![](imagen1.png)
![](imagen2.png)
:::
```

## Control de Espacio (Spans)

Puedes hacer que una imagen ocupe más de una columna o fila usando los atributos `{span=N}` (columnas) y `{rowspan=N}` (filas).

### Ejemplo: Imagen destacada arriba y dos pequeñas debajo

```markdown
::: {.grid cols=2}
![](grande.png){span=2}
![](peque1.png)
![](peque2.png)
:::
```

### Ejemplo: Imagen vertical a la izquierda y rejilla mixta

```markdown
::: {.grid cols=3}
![](vertical.png){rowspan=2}
![](derecha1.png){span=2}
![](derecha2.png)
![](derecha3.png)
:::
```

## Notas técnicas
- El filtro busca imágenes dentro del bloque `::: grid`. 
- Se aplica automáticamente el estilo de la plantilla (bordes redondeados y borde fino).
- Asegúrate de incluir `--lua-filter=filtro_grid.lua` en tu comando de Pandoc.
