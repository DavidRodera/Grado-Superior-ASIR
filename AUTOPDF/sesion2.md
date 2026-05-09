---
title:   "SESIÓN 2 - EQUIPOS DEL TALLER - MONTAJE"

author: "David Rodera y Emma Batallas"
subject: "Fundamentos de Hardware"
date: "2024–2025"
---

# Montaje RAM

## Consulta del Manual y Configuración de Canales

Antes de proceder con el montaje, se consultó el manual técnico del HP Compaq 8000 Elite SFF para identificar la disposición de los zócalos DIMM. Según la tabla de ubicaciones, el sistema requiere que el zócalo DIMM1 (color negro) esté ocupado obligatoriamente para evitar errores de post-arranque. Para optimizar el rendimiento mediante la arquitectura Dual Channel, el manual recomienda utilizar los canales de forma alterna; en este caso, se seleccionaron los slots 1 y 3 (correspondientes a los canales XMM1 y XMM3), asegurando así una configuración equilibrada entre el Canal A y el Canal B.

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/cap1.png}

## Inserción de los Módulos RAM

Para la instalación física, se utilizaron dos módulos Kingston DDR3 de 2GB. El proceso consiste en alinear la muesca del módulo con la llave del zócalo y aplicar una presión firme y constante hacia abajo con ambos dedos. Este movimiento debe mantenerse hasta que las pestañas blancas de seguridad en los extremos del slot se cierren automáticamente hacia adentro, garantizando que el módulo ha quedado perfectamente anclado y haciendo contacto eléctrico total con los pines de la placa base.

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/cap2.png}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2883.jpeg}

## Verificación del Sistema y BIOS

Una vez completado el montaje mecánico, se realizó una doble verificación. Primero, se inspeccionó visualmente que ambos módulos estuvieran alineados y nivelados en sus respectivos slots. Posteriormente, se encendió el equipo y se accedió a la pantalla de System Information de la BIOS. En este panel se confirmó el éxito de la operación al mostrar una Memory Size de 4096 MB operando correctamente en Dual Channel, detallando la presencia de los 2048 MB en cada una de las ranuras seleccionadas (XMM1 y XMM3).

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2885.jpeg}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2892.jpeg}

# Montaje Disco Duro

## Preparación y Acceso al Compartimento

El manual indica que para acceder a la bahía del disco duro, se debe primero retirar el panel de acceso del equipo. En este modelo SFF, el disco duro de 3.5 pulgadas se encuentra ubicado en una bahía interna debajo de la unidad óptica. El manual especifica que la jaula de unidades es abatible: debe rotarse hacia arriba para permitir la instalación o el reemplazo de los componentes que están debajo.

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/cap3.png}

## Inserción y Conexión de Cables

Siguiendo las indicaciones del manual, se procedió a la instalación física deslizando el disco en su compartimento. Posteriormente, se realizó la conexión del cable de alimentación y, siguiendo la jerarquía de prioridad del sistema, se conectó el cable de datos al puerto SATA0 de la placa base (identificado por ser el conector de color azul oscuro), asegurando así que el equipo reconozca correctamente esta unidad como el dispositivo de almacenamiento primario durante el arranque.

::: note
En la imagen se observa que el cable de datos está conectado al puerto SATA2 (azul claro), el cual también es plenamente funcional para el almacenamiento, aunque generalmente se reserva para unidades secundarias o lectoras ópticas.
:::

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2895.jpeg}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/cap4.png}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/cap4.png}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2896.jpeg}

## Verificación del BIOS

Para la verificación del disco duro en la BIOS, el procedimiento consiste en navegar hasta el menú Storage y seleccionar la opción Device Configuration. En este apartado, el sistema confirma la detección física del disco duro indicando su capacidad de 250 GB y su estado actual. Al aparecer listado correctamente en esta pantalla, se valida que tanto el cable de alimentación como el de datos (conectado al puerto SATA) funcionan perfectamente y que la placa base ha reconocido la unidad de almacenamiento sin conflictos.

::: note
En este caso el cable de datos se encontraba conectado al puerto SATA3 (negro). Lo recomendado era que estuviese conectado al puerto SATA0 (azul oscuro), apareciendo SATA0 en la verifiación del BIOS.
:::

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2893.jpeg}

# Conexión de Periféricos y Alimentación Externa

En este paso final, se conectaron los elementos esenciales para la puesta en marcha del equipo: el cable de alimentación a la fuente de poder, el cable de video para la pantalla (en este caso VGA) y los periféricos de entrada, teclado y ratón, a través de los puertos USB traseros. Estas conexiones permiten establecer la interfaz necesaria para que el usuario pueda interactuar con el sistema y visualizar la información de la BIOS o el sistema operativo una vez encendido el ordenador.

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2887.jpeg}

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2888.jpeg}

# Verificación del funcionamiento del equipo

Tras haber completado con éxito la instalación de los módulos de memoria RAM, el montaje del disco duro y la correcta conexión de todos los cables de alimentación y periféricos, se procedió a realizar la prueba de encendido. El equipo arrancó de manera estable, confirmando que todos los componentes han sido integrados correctamente y que el sistema se encuentra plenamente operativo y listo para su uso.

\imagen[width=0.5\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/fotos/IMG_2889.jpeg}

# Procedimiento oficial de instalación del conjunto CPU-Disipador-Ventilador

## Instalación del CPU

Para la instalación del procesador, el procedimiento exige una manipulación extremadamente cuidadosa para no dañar los pines del zócalo (socket) de la placa base.

- Apertura: Se debe presionar y desplazar hacia fuera la palanca de carga (Load Lever) para liberar la placa de retención.

- Alineación: El procesador cuenta con dos muescas de guía que deben coincidir exactamente con las pestañas del zócalo. Se debe depositar el chip verticalmente sin ejercer presión.

- Cierre: Una vez asentado, se baja la placa de carga y se vuelve a fijar la palanca en su posición de bloqueo.

## Preparación y Aplicación de Pasta Térmica

Antes de colocar el sistema de refrigeración, es obligatorio asegurar una transferencia de calor eficiente, limpiando cualquier residuo anterior con alcohol isopropílico y aplicando una pequeña cantidad (tamaño de un guisante) de compuesto térmico en el centro de la CPU. Una cantidad excesiva puede desbordarse y causar problemas térmicos.
