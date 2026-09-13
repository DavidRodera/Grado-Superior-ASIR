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
