---
tipo: "PRÁCTICA"
title: "Práctica del RA1: Operación DataShield"
author: "David Rodera - Marco Gallego"
subject: "Administración de Sistemas Gestores de Bases de Datos (ASGBD) - 22/10/2026"
curso: "2º Administración de Sistemas Informáticos en Red (2ºASIR)"
footer: "Práctica RA1 · Administración de Sistemas Gestores de Bases de Datos · ASIR"
---

# 0. Introducción

## 0.1. Contexto

El departamento de seguridad del instituto ha detectado una brecha: un antiguo alumno filtró datos por tener acceso total a una base de datos compartida. Tu equipo, formado por dos administradores junior, debe restablecer la seguridad creando un sistema de usuarios, roles y vistas seguras.

Este reto se llama **Operación DataShield** porque se refiere precisamente a construir un "escudo de protección" combinando dos pilares de seguridad en bases de datos:

1. Abstracción mediante **Vistas Seguras**: Interponer una capa intermedia para que los usuarios nunca consulten las tablas físicas reales (ocultando IPs internas yhashes de contraseñas).

2. **Modelo RBAC** (Role-Based Access Control (Control de Acceso Basado en Roles)) para roles: Restringir el acceso a nivel de usuario asignando únicamente los roles estrictamente necesarios (Principio de Mínimo Privilegio).

## 0.2. Objetivos

1. Creación de la base de datos **DataShield_DavidMarco**.

2. Configura un sistema de roles y vistas seguras que permita diferentes niveles de acceso:
- **Analistas**: solo lectura de datos no sensibles.
- **Técnicos de soporte**: modificación de registros de incidencias.
- **Administradores**: gestión completa y auditoría.

\newpage

# 1. Diseño e Implementación de la Base de Datos

## 1.1. Estructura de la Base de Datos

Nuestra base de datos **DataShield_DavidMarco** estará compuesta por tres tablas: **usuarios**, **sistemas** e **incidencias**. 

### Tabla usuarios

| **Campo** | **Tipo** | **Descripción** |
| :--- | :--- | :--- |
| id_usuario | INT | Idenficador único |
| nombre | VARCHAR(50) | Nombre y apellidos del usuario |
| rol | ENUM | Rol que desempeña (admin_seguridad, analista, soporte) |
| hash_contraseña | VARCHAR(50) | Contraseña cifrada o hash (no en claro) |

::: note
Para la columna rol usaremos ENUM en vez de VARCHAR, ya que ENUM (enumeración) es un objeto de cadena que limita los valores permitidos de una columna a una lista fija y predefinida, y como solo 3 valores a insertar en esa columna sería más correcto.
:::

### Tabla sistemas

| **Campo** | **Tipo** | **Descripción** |
| :--- | :--- | :--- |
| id_sistema | INT | Idenficador único |
| nombre_sistema | VARCHAR(50) | Nombre del servidor o aplicación |
| ip | VARCHAR(15) | Dirección IP del sistema |
| responsible | INT | Usuario responsable del sistema (FK a usuarios) |

::: note
En la columna ip, tiene un tipo VARCHAR(15) ya que una dirección IP está compuesta por 4 octetos de números del 0 al 255 separados por puntos, por lo que el máximo de caracteres es de 15.
:::

::: warning
Como hay IPs que no ocupan justo 15 caracteres el tipo VARCHAR que permite un número de caracteres menor o igual a lo indicado, si todas las IPs ocupasen 15 caracteres la mejor opción sería CHAR.
:::

### Tabla sistemas

| **Campo** | **Tipo** | **Descripción** |
| :--- | :--- | :--- |
| id_incidencia | INT | Idenficador único |
| sistema_id | INT | Sistema afectado (FK a sistemas) |
| descripcion | VARCHAR(100) | Descripción del problema |
| nivel_gravedad | ENUM | Puede ser “baja”, “media” o “alta” |
| estado | ENUM | Puede ser “pendiente”, “en curso”, “resuelta” |
| fecha | DATE | Fecha de detección |

::: note
Usaremos el tipo ENUM en las columnas nivel_gravedad y estado ya que tienen pocos valores a insertar.
:::

## 1.2. Creación de la Base de Datos

### Creación inicial

Para empezar con la creación de la base de datos, se utiliza la instrucción `DROP DATABASE IF EXISTS base_datos;` con el fin de eliminar cualquier versión previa que pueda existir con ese mismo nombre en el servidor. Esto asegura que la base de datos se cree completamente desde cero, evitando posibles errores de conflicto por tablas o datos antiguos. Posteriormente crearemos la base de datos, e indicaremos que queremos usarla.

```sql
DROP DATABASE IF EXISTS DataShield_DavidMarco;
CREATE DATABASE DataShield_DavidMarco;
USE DataShield_DavidMarco;
```

También podemos crearla de manera gráfica.

\imagen[width=0.8\textwidth]{fotos2/img1.png}
