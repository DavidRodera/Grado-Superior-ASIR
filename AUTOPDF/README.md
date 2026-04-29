# USO de AUTOPDF

## Generar pdf nuevo

1. Escribir código en **.md** (seguir **guia_plantilla.md**)
2. Usar script **generar_pdf.sh** (dentro de la carpeta **/PLANTILLA**)

## Pasar pdf antiguo al de la plantilla

1. Usar script **extraer_contenido.sh** (extrae las imagenes del pdf y el texto)
2. Reescribir el contenido a **.md** (seguir **guia_plantilla.md**)
3. Usar script **generar_pdf.sh** (dentro de la carpeta **/PLANTILLA**)

## Resumen scripts

```
---
Script: "generar_pdf.sh" "extraer_contenido.sh"
Uso: "Pasa el archivo .md a .pdf con la plantilla" "Coge de un .pdf sus imágenes y las almacena en una carpeta, y extrae el texto y lo pone en un archivo .md"
---
```
