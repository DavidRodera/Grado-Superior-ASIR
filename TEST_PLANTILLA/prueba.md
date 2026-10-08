---
title: "Guía de Prueba V2"
subtitle: "Análisis de nueva plantilla basada en ASO"
author: "David Rodera"
date: "Octubre 2026"
---

# Introducción a la nueva plantilla

Esta es una prueba de la plantilla que imita el estilo de la guía de ASO.

## Bloques de Código

Los bloques de código ahora no tienen bordes redondeados y usan un fondo muy suave.

```bash
#!/bin/bash
# Esto es un script de prueba
echo "Hola mundo"
if [ $? -eq 0 ]; then
  echo "Todo bien"
fi
```

## Avisos y Consejos

::: {.regla}
Esta es una regla de oro. No debe tener bordes redondeados y debe tener un fondo verde claro.
:::

::: {.tip}
Este es un consejo útil para el examen.
:::

::: {.aviso}
¡Atención! Comprueba siempre los espacios en los corchetes.
:::

## Tablas

| Comando | Función | Ejemplo |
|---------|---------|---------|
| `ls` | Listar archivos | `ls -l` |
| `grep` | Buscar texto | `grep "patron" archivo` |
| `chmod` | Cambiar permisos | `chmod 755 script.sh` |

## Imágenes en Rejilla (Grid)

::: {.grid cols=2}
![](fotos/img1.png)
![](fotos/img2.png)
:::

# Eficiencia de Espacio

Este bloque de código es largo y debería intentar no partirse si no cabe en la página, o simplemente seguir el flujo de `tcolorbox`.

```bash
# Simulación de bloque largo
for i in {1..20}; do
  echo "Línea $i"
done
```
