---
title:   "Ejemplo de Rejilla de Imágenes"
author:  "David Rodera"
subject: "Fundamentos de Hardware"
date:    "Curso 2024–2025"
---

# Ejemplo de Grid

Aquí tienes un ejemplo de cómo organizar las imágenes de tus trabajos de Hardware en una rejilla.

## Rejilla Básica (2 columnas)

Útil para comparar componentes o mostrar pasos de un proceso.

::: {.grid cols=2}
![Placa Base](placa_base.png)
![Microprocesador](cpu.png)
:::

## Layout Avanzado

Imagina que quieres destacar una imagen principal de la placa base y poner detalles a la derecha.

::: {.grid cols=3}
![Placa Base Completa](placa_completa.png){rowspan=2 span=2}
![Zócalo CPU](socket.png)
![Ranuras RAM](ram.png)
:::

## Galería Mixta

::: {.grid cols=2}
![Caja abierta](caja.png){span=2}
![Fuente de alimentación](fuente.png)
![Disco Duro](disco.png)
:::

---

*Nota: Para generar este PDF recuerda usar el script:*
`./generar_pdf.sh ejemplo_grid.md`
