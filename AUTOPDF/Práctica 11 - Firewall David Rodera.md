---
title:   "Práctica 11 - Firewall"

author: "David Rodera"
subject: "Planificación y Administración de Redes"
date: "2024–2025"
---

# Esquema de red

\imagen[width=\textwidth]{/home/davidrodera/Documentos/Grado-Superior-ASIR/AUTOPDF/Práctica 11 - Firewall David Rodera_images/img-000.png}

La infraestructura se compone de una red local dividida en dos segmentos, LAN1
(192.168.10.0/24 y LAN2 (192.168.20.0/24) , una zona desmilitarizada (DMZ) que alberga
servidores en la red 192.168.30.0/29 y una conexión al exterior a través de una WAN
(192.168.40.0/30) conectada a Internet. Todos estos segmentos convergen en un
cortafuegos ASA 5505, que actúa como el nodo central de control de tráfico entre las
distintas interfaces.

# Objetivo de la práctica

El propósito fundamental es configurar las reglas de filtrado en el firewall para
gestionar el flujo de datos según requisitos específicos de seguridad y conectividad. Se
busca aplicar una política de seguridad donde todo lo que no esté explícitamente
permitido esté prohibido, optimizando el firewall mediante el menor número de
entradas posible para controlar el acceso a servicios, restringir IPs específicas y
segmentar la comunicación entre las redes internas y externas.

# Ejercicios

## Ejercicio 1

El tráfico de entrada desde la WAN sólo está permitido hacia la DMZ. El tráfico desde LAN1 y LAN2 puede ir a cualquiera de las otras redes.

| # | Interfaz | E/S | Acción | Origen IP/red    | Origen puertos | Destino IP/red    | Destino puertos | Protoc. |
|---|----------|-----|--------|------------------|----------------|-------------------|-----------------|---------|
| 1 | WAN      | E   | PASS   | *                | *              | 192.168.30.0/29   | *               | *       |
| 2 | WAN      | S   | PASS   | 192.168.30.0/29  | *              | *                 | *               | *       |
| 3 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | *                 | *               | *       |
| 4 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | *                 | *               | *       |

**Regla 1:** Por la interfaz WAN de **entrada** se permite cualquier tráfico cuyo destino sea la DMZ (192.168.30.0/29). Cualquier puerto y protocolo.

**Regla 2:** Por la interfaz WAN de **salida** se permite que la DMZ (192.168.30.0/29) responda al tráfico recibido. Sin esta regla, los servidores de la DMZ no podrían devolver las respuestas hacia Internet.

**Regla 3:** Por la interfaz LAN1 de **entrada** se permite todo el tráfico de 192.168.10.0/24 hacia cualquier destino, puerto y protocolo.

**Regla 4:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia cualquier destino, puerto y protocolo.

## Ejercicio 2

El tráfico de entrada desde la WAN hacía la DMZ sólo está permitido hacía conexiones en el puerto 80. Desde la LAN1 y la LAN2 se permiten conexiones a la DMZ a los puertos 80, 21 y 22. Entre la LAN1 y la LAN2 debe de haber comunicación en ambos sentidos. Hacía la WAN sólo se permitirá el tráfico desde la LAN2.

| # | Interfaz | E/S | Acción | Origen IP/red    | Origen puertos | Destino IP/red    | Destino puertos | Protoc. |
|---|----------|-----|--------|------------------|----------------|-------------------|-----------------|---------|
| 1 | WAN      | E   | PASS   | *                | *              | 192.168.30.0/29   | 80              | *       |
| 2 | WAN      | S   | PASS   | 192.168.30.0/29  | *              | *                 | *               | *       |
| 3 | WAN      | S   | PASS   | 192.168.20.0/24  | *              | *                 | *               | *       |
| 4 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 5 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.20.0/24   | *               | *       |
| 6 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 7 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.10.0/24   | *               | *       |
| 8 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.40.0/30   | *               | *       |

**Regla 1:** Por la interfaz WAN de **entrada** se permite tráfico hacia la DMZ (192.168.30.0/29) únicamente al puerto 80 (HTTP). Se usa protocolo `*` porque HTTP puede funcionar tanto sobre TCP como UDP.

**Regla 2:** Por la interfaz WAN de **salida** se permite que la DMZ responda al tráfico recibido desde Internet. Sin esta regla los servidores web no podrían devolver sus respuestas.

**Regla 3:** Por la interfaz WAN de **salida** se permite que LAN2 (192.168.20.0/24) tenga salida a Internet.

**Regla 4:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.0/24 hacia la DMZ, únicamente a los puertos 80 (HTTP), 21 (FTP) y 22 (SSH), cualquier protocolo.

**Regla 5:** Por la interfaz LAN1 de **entrada** se permite todo el tráfico de 192.168.10.0/24 hacia LAN2 (192.168.20.0/24). Junto con la regla 7 garantiza la comunicación bidireccional.

**Regla 6:** Por la interfaz LAN2 de **entrada** se permite el tráfico de 192.168.20.0/24 hacia la DMZ, únicamente a los puertos 80, 21 y 22, cualquier protocolo.

**Regla 7:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia LAN1 (192.168.10.0/24). Junto con la regla 5 garantiza la comunicación bidireccional.

**Regla 8:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia la WAN (192.168.40.0/30). LAN1 no tiene este permiso.

## Ejercicio 3

Idéntico al anterior salvo que el servidor con dirección 192.168.30.2 no podrá ser accesible desde la WAN y el ordenador de la LAN1 con dirección 192.168.10.30 si podrá tener acceso a la WAN.

| # | Interfaz | E/S | Acción | Origen IP/red    | Origen puertos | Destino IP/red    | Destino puertos | Protoc. |
|---|----------|-----|--------|------------------|----------------|-------------------|-----------------|---------|
| 1 | WAN      | E   | BLOCK  | *                | *              | 192.168.30.2      | *               | *       |
| 2 | WAN      | E   | PASS   | *                | *              | 192.168.30.0/29   | 80              | *       |
| 3 | WAN      | S   | PASS   | 192.168.30.0/29  | *              | *                 | *               | *       |
| 4 | WAN      | S   | PASS   | 192.168.20.0/24  | *              | *                 | *               | *       |
| 5 | WAN      | S   | PASS   | 192.168.10.30    | *              | *                 | *               | *       |
| 6 | LAN1     | E   | PASS   | 192.168.10.30    | *              | 192.168.40.0/30   | *               | *       |
| 7 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 8 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.20.0/24   | *               | *       |
| 9 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 10| LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.10.0/24   | *               | *       |
| 11| LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.40.0/30   | *               | *       |

**Regla 1:** Por la interfaz WAN de **entrada** se bloquea cualquier tráfico cuyo destino sea 192.168.30.2. Debe ir **ANTES** de la regla 2 porque .30.2 pertenece a la DMZ que se permite a continuación.

**Regla 2:** Por la interfaz WAN de **entrada** se permite tráfico hacia la DMZ (192.168.30.0/29) al puerto 80, cualquier protocolo. La máquina .30.2 ya fue bloqueada por la regla 1.

**Regla 3:** Por la interfaz WAN de **salida** se permite que la DMZ responda al tráfico recibido desde Internet.

**Regla 4:** Por la interfaz WAN de **salida** se permite que LAN2 (192.168.20.0/24) tenga salida a Internet hacia la WAN (192.168.40.0/30).

**Regla 5:** Por la interfaz WAN de **salida** se permite que la máquina 192.168.10.30 tenga salida a Internet. Es la única IP de LAN1 con acceso a la WAN.

**Regla 6:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.30 hacia la WAN (192.168.40.0/30), en cualquier puerto y protocolo. Se especifica la red real en lugar del alias WAN.

**Regla 7:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.0/24 hacia la DMZ a los puertos 80, 21 y 22, cualquier protocolo.

**Regla 8:** Por la interfaz LAN1 de **entrada** se permite todo el tráfico de 192.168.10.0/24 hacia LAN2 (192.168.20.0/24).

**Regla 9:** Por la interfaz LAN2 de **entrada** se permite el tráfico de 192.168.20.0/24 hacia la DMZ a los puertos 80, 21 y 22, cualquier protocolo.

**Regla 10:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia LAN1 (192.168.10.0/24).

**Regla 11:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia la WAN (192.168.40.0/30).

## Ejercicio 4

Idéntico al anterior pero eliminando el acceso desde cualquier red a la dirección 87.92.33.55 de Internet y permitiendo el acceso desde la WAN al puerto 22 de la máquina 192.168.30.1 y al mismo puerto de la máquina 192.168.20.10 .

| #  | Interfaz | E/S | Acción | Origen IP/red    | Origen puertos | Destino IP/red    | Destino puertos | Protoc. |
|----|----------|-----|--------|------------------|----------------|-------------------|-----------------|---------|
| 1  | LAN1     | E   | BLOCK  | *                | *              | 87.92.33.55       | *               | *       |
| 2  | LAN2     | E   | BLOCK  | *                | *              | 87.92.33.55       | *               | *       |
| 3  | WAN      | E   | BLOCK  | *                | *              | 192.168.30.2      | *               | *       |
| 4  | WAN      | E   | PASS   | *                | *              | 192.168.30.1      | 22              | TCP     |
| 5  | WAN      | E   | PASS   | *                | *              | 192.168.20.10     | 22              | TCP     |
| 6  | WAN      | E   | PASS   | *                | *              | 192.168.30.0/29   | 80              | *       |
| 7  | WAN      | S   | PASS   | 192.168.30.0/29  | *              | *                 | *               | *       |
| 8  | WAN      | S   | PASS   | 192.168.20.0/24  | *              | *                 | *               | *       |
| 9  | WAN      | S   | PASS   | 192.168.10.30    | *              | *                 | *               | *       |
| 10 | LAN1     | E   | PASS   | 192.168.10.30    | *              | 192.168.40.0/30   | *               | *       |
| 11 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 12 | LAN1     | E   | PASS   | 192.168.10.0/24  | *              | 192.168.20.0/24   | *               | *       |
| 13 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.30.0/29   | 80,21,22        | *       |
| 14 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.10.0/24   | *               | *       |
| 15 | LAN2     | E   | PASS   | 192.168.20.0/24  | *              | 192.168.40.0/30   | *               | *       |

**Regla 1:** Por la interfaz LAN1 de **entrada** se bloquea cualquier tráfico cuyo destino sea 87.92.33.55, en cualquier puerto y protocolo. Debe ir al inicio de LAN1 para tener precedencia sobre los permisos de salida.

**Regla 2:** Por la interfaz LAN2 de **entrada** se bloquea cualquier tráfico cuyo destino sea 87.92.33.55, en cualquier puerto y protocolo. Igualmente al inicio de LAN2.

**Regla 3:** Por la interfaz WAN de **entrada** se bloquea todo tráfico hacia 192.168.30.2. Debe preceder a la regla 6 que permite HTTP a toda la DMZ.

**Regla 4:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 22 (SSH) de 192.168.30.1. Acceso SSH desde Internet a ese servidor concreto de la DMZ.

**Regla 5:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 22 (SSH) de 192.168.20.10, máquina de LAN2 accesible desde Internet.

**Regla 6:** Por la interfaz WAN de **entrada** se permite tráfico al puerto 80 (HTTP, protocolo `*`) hacia la DMZ. La máquina .30.2 ya fue bloqueada en la regla 3.

**Regla 7:** Por la interfaz WAN de **salida** se permite que la DMZ responda al tráfico recibido desde Internet.

**Regla 8:** Por la interfaz WAN de **salida** se permite que LAN2 tenga salida a Internet.

**Regla 9:** Por la interfaz WAN de **salida** se permite que 192.168.10.30 tenga salida a Internet. Único equipo de LAN1 con ese acceso.

**Regla 10:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.30 hacia la WAN (192.168.40.0/30), en cualquier puerto y protocolo.

**Regla 11:** Por la interfaz LAN1 de **entrada** se permite el tráfico TCP de 192.168.10.0/24 hacia la DMZ a los puertos 80, 21 y 22.

**Regla 12:** Por la interfaz LAN1 de **entrada** se permite todo el tráfico de 192.168.10.0/24 hacia LAN2 (192.168.20.0/24).

**Regla 13:** Por la interfaz LAN2 de **entrada** se permite el tráfico de 192.168.20.0/24 hacia la DMZ a los puertos 80, 21 y 22, cualquier protocolo.

**Regla 14:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia LAN1 (192.168.10.0/24).

**Regla 15:** Por la interfaz LAN2 de **entrada** se permite todo el tráfico de 192.168.20.0/24 hacia la WAN (192.168.40.0/30). El destino 87.92.33.55 ya fue bloqueado en la regla 2.

## Ejercicio 5

El tráfico ICMP desde la WAN hacía la DMZ debe de estar permitido salvo a la IP
192.168.30.1. Además, debe de estar permitido el acceso al puerto 80 desde la WAN a
las máquinas 192.168.30.1 y 192.168.30.2, el acceso al puerto 21 de la 192.168.30.3 y al
puerto 22 de todas las máquinas de la DMZ. La LAN1 y la LAN2 no deben de tener
comunicación, pero ambas deben de tener salida a Internet y comunicación total con la
DMZ salvo las máquinas 192.168.10.5, 192.168.20.15 y 192.168.20.16 que no deben de
tener salida a Internet. Desde la WAN debe de poder accederse también a los puertos
22 de la 192.168.20.1 y la 192.168.10.1. Además, el tráfico desde la LAN2 con destino los
puertos 3840 al 3890 debe de estar prohibido y el tráfico del protocolo UDP debe de
estar prohibido en la LAN1.

| #  | Interfaz | E/S | Acción | Origen IP/red                   | Origen puertos | Destino IP/red    | Destino puertos | Protoc. |
|----|----------|-----|--------|---------------------------------|----------------|-------------------|-----------------|---------|
| 1  | WAN      | E   | BLOCK  | *                               | *              | 192.168.30.1      | *               | ICMP    |
| 2  | WAN      | E   | PASS   | *                               | *              | 192.168.30.0/29   | *               | ICMP    |
| 3  | WAN      | E   | PASS   | *                               | *              | 192.168.30.1      | 80              | *       |
| 4  | WAN      | E   | PASS   | *                               | *              | 192.168.30.2      | 80              | *       |
| 5  | WAN      | E   | PASS   | *                               | *              | 192.168.30.3      | 21              | TCP     |
| 6  | WAN      | E   | PASS   | *                               | *              | 192.168.30.0/29   | 22              | TCP     |
| 7  | WAN      | E   | PASS   | *                               | *              | 192.168.20.1      | 22              | TCP     |
| 8  | WAN      | E   | PASS   | *                               | *              | 192.168.10.1      | 22              | TCP     |
| 9  | WAN      | S   | PASS   | 192.168.30.0/29                 | *              | *                 | *               | *       |
| 10 | WAN      | S   | PASS   | 192.168.10.0/24                 | *              | *                 | *               | *       |
| 11 | WAN      | S   | PASS   | 192.168.20.0/24                 | *              | *                 | *               | *       |
| 12 | LAN1     | E   | BLOCK  | *                               | *              | *                 | *               | UDP     |
| 13 | LAN1     | E   | BLOCK  | 192.168.10.0/24                 | *              | 192.168.20.0/24   | *               | *       |
| 14 | LAN1     | E   | BLOCK  | 192.168.10.5                    | *              | 192.168.40.0/30   | *               | *       |
| 15 | LAN1     | E   | PASS   | 192.168.10.0/24                 | *              | 192.168.30.0/29   | *               | *       |
| 16 | LAN1     | E   | PASS   | 192.168.10.0/24                 | *              | 192.168.40.0/30   | *               | *       |
| 17 | LAN2     | E   | BLOCK  | 192.168.20.0/24                 | *              | *                 | 3840-3890       | *       |
| 18 | LAN2     | E   | BLOCK  | 192.168.20.0/24                 | *              | 192.168.10.0/24   | *               | *       |
| 19 | LAN2     | E   | BLOCK  | 192.168.20.15,192.168.20.16     | *              | 192.168.40.0/30   | *               | *       |
| 20 | LAN2     | E   | PASS   | 192.168.20.0/24                 | *              | 192.168.30.0/29   | *               | *       |
| 21 | LAN2     | E   | PASS   | 192.168.20.0/24                 | *              | 192.168.40.0/30   | *               | *       |

**Regla 1:** Por la interfaz WAN de **entrada** se bloquea el tráfico ICMP cuyo destino sea 192.168.30.1. Debe ir **ANTES** de la regla 2 para excluir esta IP del permiso ICMP general a la DMZ.

**Regla 2:** Por la interfaz WAN de **entrada** se permite el tráfico ICMP hacia toda la DMZ (192.168.30.0/29). La IP .30.1 fue excluida en la regla 1.

**Regla 3:** Por la interfaz WAN de **entrada** se permite tráfico al puerto 80 (protocolo `*`) hacia 192.168.30.1. Aunque no admite ICMP, sí admite HTTP.

**Regla 4:** Por la interfaz WAN de **entrada** se permite tráfico al puerto 80 (protocolo `*`) hacia 192.168.30.2. Acceso HTTP público a ese servidor.

**Regla 5:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 21 (FTP) únicamente hacia 192.168.30.3.

**Regla 6:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 22 (SSH) hacia todas las máquinas de la DMZ (192.168.30.0/29).

**Regla 7:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 22 (SSH) hacia 192.168.20.1 de LAN2.

**Regla 8:** Por la interfaz WAN de **entrada** se permite tráfico TCP al puerto 22 (SSH) hacia 192.168.10.1 de LAN1.

**Reglas 9–11:** Por la interfaz WAN de **salida** se permite que la DMZ, LAN1 y LAN2 puedan enviar tráfico de respuesta o de salida hacia Internet.

**Regla 12:** Por la interfaz LAN1 de **entrada** se bloquea todo el tráfico UDP. Es la primera regla de LAN1 para que se aplique antes que cualquier permiso posterior.

**Regla 13:** Por la interfaz LAN1 de **entrada** se bloquea el tráfico de 192.168.10.0/24 hacia LAN2 (192.168.20.0/24). LAN1 y LAN2 no se comunican entre sí.

**Regla 14:** Por la interfaz LAN1 de **entrada** se bloquea el tráfico de 192.168.10.5 hacia la WAN (192.168.40.0/30). Esta IP no tiene salida a Internet.

**Regla 15:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.0/24 hacia la DMZ (192.168.30.0/29), en cualquier puerto (excepto UDP, bloqueado en regla 12).

**Regla 16:** Por la interfaz LAN1 de **entrada** se permite el tráfico de 192.168.10.0/24 hacia la WAN (192.168.40.0/30). La IP .10.5 ya fue bloqueada en la regla 14.

**Regla 17:** Por la interfaz LAN2 de **entrada** se bloquea el tráfico de 192.168.20.0/24 hacia cualquier destino en los puertos 3840–3890. **Esta regla va primera en LAN2** para garantizar que ningún permiso posterior pueda esquivarla.

**Regla 18:** Por la interfaz LAN2 de **entrada** se bloquea el tráfico de 192.168.20.0/24 hacia LAN1 (192.168.10.0/24). LAN2 tampoco puede comunicarse con LAN1.

**Regla 19:** Por la interfaz LAN2 de **entrada** se bloquea el tráfico de 192.168.20.15 y 192.168.20.16 hacia la WAN (192.168.40.0/30). Estas IPs no tienen salida a Internet.

**Regla 20:** Por la interfaz LAN2 de **entrada** se permite el tráfico de 192.168.20.0/24 hacia la DMZ (192.168.30.0/29), en cualquier puerto y protocolo.

**Regla 21:** Por la interfaz LAN2 de **entrada** se permite el tráfico de 192.168.20.0/24 hacia la WAN (192.168.40.0/30). Los puertos 3840-3890 y las IPs .20.15/.20.16 ya fueron bloqueados en las reglas 17 y 19.

# Conclusiones

Es clave poner las reglas en el orden correcto, ya que el cortafuegos las lee de arriba
abajo y la primera que coincide es la que se aplica. Además, usar una política donde
"todo lo que no permitas está prohibido" hace que la red sea mucho más segura y que
la tabla de reglas sea corta y fácil de gestionar.
