---
title:   "Tarea 1.1"

author: "David Rodera"
subject: "Arquitecturas en la nube"
date: "2026–2027"
---

### Caso 1 — La tienda y el Black Friday

**a) ¿Qué problema presenta esta solución durante la mayor parte del año?**

Al mantener más servidores de los que habitualmente se utilizan hay una estructura sobredimensionada, generando costes fijos e ineficiencias de mantenimiento continuo.

**b) Explica cómo podría ayudar el concepto de elasticidad.**

La elasticidad permite escalar la capacidad de recursos de manera automática para adaptarse al tráfico comercial.

**c) ¿Qué diferencia habría entre comprar esos servidores y consumir capacidad cloud únicamente cuando fuese necesaria desde el punto de vista CAPEX/OPEX?**

Desde el punto de vista CAPEX, la empresa realizaría una alta inversión en hardware e infraestructura que será independiente al uso que al final se le dé, en cambio, desde el punto de vista de OPEX no habrá una inversión inicial masiva y solo se pagará por los recursos consumidos.

### Caso 2 — No queremos llevarlo todo a la nube

**a) ¿Qué modelo de despliegue propondrías: cloud, on-premises o híbrido? Justifica la respuesta.**

Propondría un modelo de despliegue híbrido debido a que este modelo combina entornos privados y públicos.

**b) ¿Significa utilizar cloud que la empresa necesariamente tenga que abandonar toda su infraestructura propia?**

No, ya que el modelo híbrido permite mantener y convivir con la infraestructura existente de uso exclusivo en la organización según sus necesidades operativas.

**c) ¿Qué ventajas puede tener esta estrategia?**

Las mayores ventajas son la flexibidad al poderse preservar los datos críticos bajo la alta seguridad del CPD propio y utilizar la nube para un despliegue acelerado de la nueva web, y la eficiencia de costes al minimizar los costes fijos al evitar la adquisición de hardware adicional.

**d) ¿Qué posibles inconvenientes crees que puede introducir tener infraestructura en dos entornos diferentes?**

Los posibles inconvenientes serán la integración de canales de seguros entre los dos entornos, la latencia de red al cominucarse los dos entornos y la gran carga administrativa al gestionar politicas de seguridad de forma dual.

### Caso 3 — ¿Máquina virtual, plataforma o aplicación?

**a) Clasifica A, B y C como IaaS, PaaS o SaaS.**

- A: IaaS
- B: PaaS
- C: SaaS

**b) Justifica cada decisión.**

En la situación A se le otorga el servidor Linux pero tiene control total del sistema operativo y su configuración. En la situación B se les otorga una infraestructura, no gestionan el sistema operativo, pero tienen control del desarrollo y despliegue de la app. 

**c) Ordena los tres modelos desde aquel en el que el cliente tiene mayor control sobre la infraestructura hasta aquel en el que tiene menor control.**

IaaS, PaaS y SaaS.

**d) ¿Cuál de los tres modelos se parece más a trabajar directamente con una máquina virtual tradicional?**

Se parece más el modelo IaaS, porque se basa en proporcionar servidores virtuales sobre los que el usuario tiene administración directa.

### Caso 4 — Construyendo nuestro primer sistema en AWS

**a) ¿Qué servicio utilizarías para cada necesidad?**

- Red virtual propia: VPC
- Máquina virtual para la aplicación: EC2
- Disco asociado a la máquina: EBS
- Almacenar miles de fotografías independientemente: S3
- Base de datos relacional administrada: RDS
- Control de permisos de usuarios: IAM

**b) Explica brevemente qué función realiza cada uno.**

- VPC: Define una red privada y aislada dentro de AWS para desplegar los recursos de forma segura.
- EC2: Proporciona servidores virtuales bajo el modelo IaaS para ejecutar la aplicación.
- EBS: Funciona como un disco duro de bloques directamente conectado a EC2 para el sistema operativo y archivos temporales.
- S3: Almacenamiento de objetos desacoplado, escalable y accesible mediante peticiones web.
- RDS: Servicio gestionado que automatiza tareas de mantenimiento y respaldos de bases de datos relacionales.
- IAM: Gestiona las identidades, usuarios, roles y políticas de seguridad para el acceso a la infraestructura.

**c) Si mañana eliminásemos la máquina EC2, ¿por qué conceptualmente no deberíamos considerar S3 simplemente como “el disco duro de EC2”?**

S3 es un servicio de almacenamiento de objetos que no está vinculado al ciclo de vida de la máquina virtual.** A diferencia de un disco asociado (EBS), si mañana se elimina la instancia EC2, los archivos almacenados en S3 se mantienen intactos y se pueden acceder directamente mediante la red/API desde otros servidores, aplicaciones o usuarios autorizados.

**d) Dibuja un esquema muy sencillo que represente cómo crees que podrían relacionarse estos elementos. No importa que todavía no sea una arquitectura técnicamente perfecta.**

\imagen[width=0.8\textwidth]{fotos/I.jpeg}
