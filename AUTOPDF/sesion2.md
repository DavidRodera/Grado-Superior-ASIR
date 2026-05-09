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

## Instalación de la CPU

Según las especificaciones técnicas de la placa base (Capítulo 3), el sistema utiliza un procesador con arquitectura Intel Core 2 en un paquete FC-LGA775.

- Montaje: Se realiza sobre un zócalo de fuerza de inserción cero (ZIF Socket). El procedimiento oficial requiere liberar la palanca de carga para abrir la placa de retención, alinear las muescas del procesador con las del zócalo y cerrar la palanca para asegurar el contacto de los 775 pines sin aplicar fuerza manual sobre el chip.

## Instalación del Disipador de Calor (Heatsink)
El manual técnico define el disipador como una pieza crítica para la estabilidad del sistema:

- Ajuste: El disipador se asienta sobre el procesador una vez que este ha sido bloqueado en el zócalo. Aunque este manual no detalla el giro de los tornillos, especifica que el diseño está hecho para mantener una presión constante sobre el IHS (Integrated Heat Spreader) del procesador para maximizar la transferencia térmica.

- Pasta Térmica: Es imperativo que exista una interfaz térmica entre el procesador y el disipador para evitar el sobrecalentamiento que activaría las protecciones del sistema descritas en el capítulo de gestión de energía.

## Instalación y Conexión del Ventilador

El ventilador es de tipo velocidad variable y es gestionado automáticamente por la placa base:

- Conexión: El cable del ventilador debe conectarse obligatoriamente al cabezal de la placa base identificado en los diagramas como P8 (CPU Fan Connector).

- Funcionamiento: El sistema utiliza una lógica de control térmico que ajusta las revoluciones por minuto (RPM) del ventilador basándose en los sensores de temperatura internos de la CPU. Si no se conecta correctamente al puerto P8, el sistema emitirá un error de diagnóstico al arrancar.

## Manual de referencia

- Página 3-2 (Capítulo 3.2): Especificaciones del procesador Intel y el zócalo de montaje.

- Página 4-13 (Capítulo 4.5.4): Detalles sobre la lógica de control del ventilador y gestión térmica.

- Página 7-8 (Capítulo 7, Tabla 7-7): Localización y descripción del conector P8 para el ventilador de la CPU.

::: link
[Manual Technical Reference Guide HP Compaq 8000 Elite Series Business Desktop Computers](https://h10032.www1.hp.com/ctg/Manual/c01960471.pdf)
:::
