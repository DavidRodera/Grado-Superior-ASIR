---
title:   "Guía Copias de Seguridad"
author:  "David Rodera"
subject: "Gestión Bases de Datos"
date:    "2024–2025"
---

# Uso de Copias de Seguridad

Una copia de seguridad es esencial para garantizar la integridad de los datos ante cualquier fallo de hardware, error humano o ataque externo. En el entorno de MySQL, disponemos de varios métodos dependiendo de nuestras necesidades de almacenamiento y tiempo de recuperación.

## Copia de Seguridad Completa

Una copia de seguridad completa es el respaldo total de todos los archivos. Se utiliza principalmente como punto de partida para establecer una base maestra antes de aplicar métodos incrementales o diferenciales. Se crea de la siguiente manera:

### 1. Cargar o tener cargada la BBDD

```bash
mysql -u admin -p < base_de_datos.sql
```

\imagen[width=0.85\textwidth]{imagenes/img-000.png}

::: note
Asegúrate de que el usuario tenga los permisos necesarios (`GRANT ALL PRIVILEGES`) sobre la base de datos de destino antes de iniciar la carga.
:::

### 2. Crear copia de seguridad

```bash
mysqldump -u admin -p base_de_datos > copia_inicial.sql
```

\imagen[width=0.85\textwidth]{imagenes/img-001.png}

### 3. Cargar copia de seguridad completa

```bash
mysql -u admin -p base_de_datos < copia_inicial.sql
```

## Copia de Seguridad Incremental

Una copia de seguridad incremental es un respaldo que solo guarda los datos modificados desde la última copia realizada, ya sea completa o incremental. En MySQL, esto se logra extrayendo los cambios registrados en los **logs binarios**, lo que permite ahorrar mucho tiempo y espacio en disco.

::: tip
Es una técnica fundamental para la recuperación en un punto exacto en el tiempo sin tener que procesar toda la base de datos de nuevo.
:::

### 1. Realizar un FLUSH LOGS;

```sql
FLUSH LOGS;
```

Este comando actualiza el registro y almacena los cambios realizados durante este.

### 2. Realizar una modificación en la BBDD

```sql
UPDATE almacenes SET cod_almacen = REPLACE(cod_almacen, '_', '');
```

### 3. Realizar otro FLUSH LOGS; y comprobar el log con SHOW MASTER STATUS;

\imagen[width=0.4\textwidth]{imagenes/img-002.png}

Tomaremos el log anterior, que tendrá almacenada la última modificación, en este caso el `binlog.000204`.

### 4. Crear copia de seguridad

```bash
mysqlbinlog --read-from-remote-server -u admin -p -h localhost binlog.número_anterior > copia_incremental_cambio.sql
```

\imagen[width=0.85\textwidth]{imagenes/img-003.png}

### 5. Cargar copia de seguridad completa y después la incremental

```bash
mysql -u admin -p base_de_datos < copia_inicial.sql
mysql -u admin -p base_de_datos < copia_incremental_cambio.sql
```

::: warning
Si hay muchas copias de seguridad incrementales, debemos cargarlas sucesivamente en el orden exacto en que fueron creadas.
:::

## Copia de Seguridad Diferencial

Una copia de seguridad diferencial es un respaldo que almacena todos los cambios realizados desde el último backup **completo**. A diferencia de la incremental, esta copia es acumulativa, por lo que su tamaño crece cada día hasta que se realice un nuevo ciclo de respaldo total.

Su gran ventaja es que simplifica la restauración, ya que solo necesitas el archivo base y la diferencial más reciente para recuperar los datos.

### 1. Juntar las copias de seguridad incrementales

```bash
cat incremental_1.sql incremental_2.sql incremental_3.sql > copia_diferencial.sql
```

Para hacerlo con copias de seguridad incrementales ya almacenadas:

```bash
mysqlbinlog --read-from-remote-server -u admin -p binlog.000001 binlog.000002 binlog.000003 > copia_diferencial.sql
```

::: note
Este comando une los binlogs indicados en un único archivo de respaldo diferencial.
:::

### 2. Cargar copia de seguridad completa y después la diferencial

```bash
mysql -u admin -p base_de_datos < copia_inicial.sql
mysql -u admin -p base_de_datos < copia_diferencial.sql
```
