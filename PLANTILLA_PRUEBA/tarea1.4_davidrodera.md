---
tipo: "TAREA"
title: "Tarea 1.4 - Los 6 pilares de AWS Well-Architected Framework"
author: "David Rodera"
subject: "Nube"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Tarea 1.4 - David Rodera"
---

## Parte 1. Los seis pilares

1. **Excelencia operativa:** que podamos desplegar, vigilar y gestionar los sistemas sin complicaciones, y aprender de los fallos para mejorar.
2. **Seguridad:** proteger los datos y los sistemas controlando quién puede acceder y a qué.
3. **Fiabilidad:** que el servicio siga funcionando aunque algo falle y que se recupere rápido cuando pasa.
4. **Eficiencia del rendimiento:** usar los recursos de computación que de verdad hacen falta y adaptarlos cuando cambia la demanda.
5. **Optimización de costes:** pagar solo por lo que se necesita y evitar gastos que no aportan nada.
6. **Sostenibilidad:** reducir el impacto ambiental de la infraestructura usando solo los recursos y la energía necesarios.

---

## Parte 2. Evalúa tu proyecto 1.1

| Pilar | ¿Qué hemos hecho bien en el proyecto? | ¿Qué mejorarías? |
|-------|----------------------------------------|-------------------|
| **Seguridad** | Usamos dos grupos de seguridad con reglas distintas. SG-BASTION solo admite SSH desde mi IP y SG-WEB solo admite SSH desde SG-BASTION, así que nadie puede entrar por SSH a los servidores web desde internet. Además, el HTTP quedó limitado al puerto 80 y las tres máquinas usaron la misma clave `.pem`. | Pondría los servidores web en subredes privadas, sin IP pública, y los dejaría accesibles solo a través de un balanceador. También añadiría HTTPS con certificado, porque ahora todo el tráfico web va sin cifrar. |
| **Fiabilidad** | Repartimos los dos servidores Apache en subredes y zonas de disponibilidad distintas (us-east-1b y us-east-1c), de modo que un fallo en una zona no afectaría a las dos máquinas. Además, el User Data instala Apache solo, lo que permite repetir el despliegue igual cada vez. | Pondría un Application Load Balancer delante de los dos servidores, con comprobaciones de salud, y un grupo de Auto Scaling para reemplazar automáticamente las instancias que fallen. Así tener dos servidores serviría de algo y no dependeríamos de una IP pública concreta por servidor. |

---

## Parte 3. Una decisión de arquitectura

**Si uno de nuestros dos servidores Apache dejara de funcionar, ¿la infraestructura garantiza que los usuarios puedan seguir accediendo automáticamente a la web? ¿Por qué? ¿Qué servicio de AWS podría ayudar a resolverlo?**

No, no lo garantiza. Aunque los servidores están en zonas de disponibilidad distintas, cada uno tiene su propia IP pública y no hay nada delante que detecte el fallo ni reparta las peticiones. Si un usuario accede a la IP del servidor que se ha caído, verá un error hasta que alguien lo arregle a mano, porque nada lo redirige al otro.

El servicio que lo resolvería es **Elastic Load Balancing**, en concreto un **Application Load Balancer**. Recibiría todas las peticiones en un único punto de entrada, comprobaría periódicamente qué servidores responden y enviaría el tráfico solo a los que estén sanos. Como nuestras instancias ya están en dos zonas de disponibilidad, encajaría bien con lo que ya tenemos. Para completarlo se podría añadir **Auto Scaling**, que lanzaría una instancia nueva para sustituir a la que ha fallado.
