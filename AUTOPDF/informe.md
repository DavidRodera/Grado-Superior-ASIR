---
title:   "Informe sobre los Centros de Proceso de Datos"

author: "David Rodera y Sergio Díaz"
subject: "Fundamentos de Hardware"
date: "2024–2025"
---

# Definición técnica de un CPD

Un CPD (Centro de Procesamiento de Datos), también conocido como data center, es una  instalación que centraliza las operaciones y la infraestructura de TI de una organización, en la que se almacenan, procesan, tratan y difunden datos y aplicaciones.

# Estructura de un CPD. Organización.

La estructura de un CPD combina tanto elementos informáticos como instalaciones de soporte, y se organiza en base a tres pilares y una clasificación por niveles:

## Los pilares informáticos

### Computación

Formada por potentes servidores que aportan la memoria y la fuerza de procesamiento necesaria para ejecutar aplicaciones.

### Almacenamiento

Unidades de disco (tanto rígidos como de estado sólido) donde se guardan de forma masiva los datos corporativos.

### Redes

El cableado y los equipos (como routers o switches) encargados de conectar el centro de datos con el resto del mundo exterior.

## Las infraestructuras de soporte

Son los sistemas que mantienen vivos a los ordenadores. Destacan las instalaciones eléctricas de respaldo y los sistemas de climatización, indispensables para mantener la temperatura y la humedad en niveles estrictos y evitar que los equipos se quemen.

## Clasificación de la estructura (Niveles o Tiers)

La confiabilidad de un CPD se mide del 1 al 4. Un Tier 1 es una infraestructura básica (similar a una sala de servidores común), mientras que un Tier 4 representa el nivel más alto de la industria, diseñado con sistemas duplicados para asegurar que el centro siga funcionando ante cualquier fallo.

# Seguridad física y lógica

La seguridad de un CPD es extrema debido a que custodian los datos más valiosos y confidenciales de una organización, se divide en dos áreas principales.

## Seguridad Física

Es la protección del recinto contra amenazas materiales u operativas. Incluye blindar el edificio contra desastres naturales, incendios o robos. Asimismo, cuenta con estrictos controles de acceso para que nadie no autorizado pueda manipular las máquinas y dispone de sistemas de energía alternativos para evitar que un apagón general apague los servidores.

## Seguridad Lógica

Es la protección del entorno virtual y digital. Consiste en blindar el software y las conexiones de red contra accesos no autorizados, mitigar ataques cibernéticos y evitar el robo de información a través de virus o intrusos digitales.

# Hardware específico del CPD del CSIC. Características

## Nodos de Computación (Clúster Local)

Servidores en formato rack (habitualmente de fabricantes como IBM/Lenovo, HP o Dell) equipados con procesadores de alta densidad de núcleos (Intel Xeon o AMD EPYC) optimizados para la ejecución de algoritmos bioinformáticos y análisis de imágenes médicas.

## Aceleración Gráfica (GPUs)

Incorporación de tarjetas GPU especializadas (como NVIDIA de arquitectura Enterprise) orientadas al procesamiento paralelo, esenciales para tareas de Machine Learning aplicado a la medicina predictiva, microscopía de alta resolución y plegamiento de proteínas.

## Sistemas de Almacenamiento Masivo (Storage)

Cabinas NAS/SAN híbridas: Combinan discos de estado sólido (SSD NVMe) para el acceso rápido a bases de datos activas y discos HDD de alta capacidad para el almacenamiento de históricos de secuenciación de ADN.

- Redundancia de datos: Configuraciones RAID avanzadas y sistemas de réplica automatizada para evitar cualquier pérdida de información científica sensible. 

## Hardware de Red de Alta Velocidad

Conmutadores (Switches) de baja latencia con conexiones internas de 10 GbE o 40 GbE para garantizar el trasvase rápido de archivos de gran volumen entre los nodos de cálculo y las cabinas de almacenamiento.

# Infraestructura específica del CPD del CSIC. Características

## Climatización y Control Ambiental (HVAC)

Sistemas de refrigeración de precisión encargados de mantener la temperatura (generalmente entre 20°C y 22°C) y la humedad relativa estables. 

- Uso frecuente de arquitecturas de pasillos fríos y pasillos calientes para optimizar el flujo de aire y reducir el consumo eléctrico de los ventiladores. 

## Suministro Eléctrico y Respaldo 

- Sistemas de Alimentación Ininterrumpida (SAI/UPS): Protegen los servidores frente a picos de tensión o microcortes, manteniendo el CPD operativo el tiempo suficiente para que entren en juego los sistemas alternativos.

- Grupo Electrógeno (Generador Diésel): Garantiza la continuidad del suministro y la autonomía de las salas de datos durante apagones prolongados en la red eléctrica general. 

## Seguridad Física y Lógica

- Protección contra incendios: Sistemas de detección precoz de humos (tipo aspiración) combinados con extinción mediante gases inertes o agentes limpios (que apagan el fuego por inundación de gas sin dañar el hardware electrónico). 

- Control de accesos: Restricción física a las salas de servidores mediante tarjetas magnéticas o control biométrico. 

## Conectividad Exterior

Enlace directo de alta velocidad a la red RedIRIS (la red académica y de investigación española), lo que permite al IIBM interconectarse con los supercomputadores del CSIC y otras bases de datos biomédicas europeas de manera ultrarrápida.

# Bibliografia

Información CPD: [Xataka](https://www.xataka.com/pro/cpd-que-centro-procesamiento-datos-como-funciona)

La información detallada en los apartados de Hardware e Infraestructura del CSIC está basada en el centro IIBM (sitio de prácticas de Sergio Díaz).
