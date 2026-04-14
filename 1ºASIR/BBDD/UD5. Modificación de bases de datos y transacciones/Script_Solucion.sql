use gha_analytics;

-- 1. Normalización de Identidad (Pacientes)
SELECT * FROM pacientes;
SET SQL_SAFE_UPDATES = 0;
SELECT nif FROM pacientes GROUP BY nif HAVING COUNT(nif) > 1; -- Comprobar los NIFs duplicados
DELETE p1 FROM pacientes p1 INNER JOIN pacientes p2 ON p1.nif = p2.nif WHERE p1.id > p2.id; -- Eliminar los NIFs duplicados
SELECT * FROM pacientes WHERE NOT (CHAR_LENGTH(nif) = 9 AND nif REGEXP '^[0-9]{8}[ABCDEFGHJKLMNPQRSTVWXYZ]{1}$'); -- Comprobar los formatos erroneos de NIFs
UPDATE pacientes SET nif = REPLACE(nif,'-',''); -- Quitar '-' de los NIFs
UPDATE pacientes SET nif = TRIM(nif); -- Quitar espacios sobrantes de los NIFs
DELETE p1 FROM pacientes p1 WHERE NOT (CHAR_LENGTH(nif) = 9 AND nif REGEXP '^[0-9]{8}[A-Z]{1}$'); -- Borrar aquellos pacientes cuyos NIFs no cumplan los requisitos y no se puedan arreglar
ALTER TABLE pacientes MODIFY COLUMN nif CHAR(9) UNIQUE NOT NULL; -- Hacer que la columna nif sea única, no este vacía y que su formato sea  una cadena de exactamente 9 caracteres 
SET SQL_SAFE_UPDATES = 1;

-- 2. Consistencia de Colegiados (Médicos)
SELECT * FROM medicos;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM medicos WHERE NOT (CHAR_LENGTH(num_colegiado) = 11 AND num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}$'); -- Comprobar los formatos erroneos de num_colegiado
UPDATE medicos SET num_colegiado = CONCAT('COL-', num_colegiado) WHERE num_colegiado NOT LIKE 'COL%'; -- Añadir el prefijo 'COL' al inicio de aquellos códigos que no lo contengan
UPDATE medicos SET num_colegiado = REPLACE(num_colegiado,'/','-'); -- Sustituir '/' por '-'
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 4, 0, '-') WHERE num_colegiado NOT LIKE ('___-%'); -- Añadir el '-' después de 'COL' si no hay uno
UPDATE medicos SET num_colegiado = REPLACE(num_colegiado,'INV','99') WHERE num_colegiado LIKE '%INV%';
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 7, 0, '-') WHERE num_colegiado NOT LIKE ('___-__-%'); -- Añadir el '-' después del número de provincia si no hay uno
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 8, 0, '0') WHERE NOT num_colegiado REGEXP('^COL-[0-9]{2}-[0-9]{4}$'); -- Añadir un número al principio de los número que no poseen 4 carácteres
ALTER TABLE medicos ADD CONSTRAINT chk_medicos_num_colegiado CHECK (num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}$'); -- Aplicar la restricción CHECK para el formato de num_colegiado
SET SQL_SAFE_UPDATES = 1; 

-- 3. Integridad Referencial  
SELECT * FROM medicos;
SELECT * FROM visitas;
SELECT * FROM pacientes;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM medicos LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id WHERE especialidades.id IS NULL; -- Comprobar médicos sin especialidades
UPDATE medicos LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id SET medicos.especialidad_id = (SELECT id FROM especialidades WHERE nombre = 'Medicina General') WHERE especialidades.id IS NULL; -- Cambiamos los ids huérfanos en especialidades por el id de 'Medicina General'
DESCRIBE medicos; -- Comprobar si hay FKs
ALTER TABLE medicos ADD CONSTRAINT fk_especialidad_id FOREIGN KEY (especialidad_id) REFERENCES especialidades (id) ON UPDATE CASCADE ON DELETE CASCADE; -- Añadir la FK correspondiente en medicos	
DESCRIBE pacientes; -- Comprobar si hay FKs
-- Como hay ids huerfanos en la tabla visitas no se podrán instaurar  las FKs correspondientes, por lo que hay que realizar un saneamiento anteriormente
DESCRIBE visitas; -- Comprobar si hay FKs
SELECT * FROM visitas LEFT JOIN pacientes ON visitas.paciente_id = pacientes.id WHERE pacientes.id IS NULL; -- Comprobar visitas con pacientes no registrados (como antes había un paciente duplicado que ha sido borrado aparece también como que es NULL, además hay ese mismo paciente ha sido atendido por un médico inexistente)
DELETE visitas from visitas LEFT JOIN pacientes ON visitas.paciente_id = pacientes.id WHERE pacientes.id IS NULL; -- Borrar visitas con pacientes inexistentes (solo basta con eso)
ALTER TABLE visitas ADD CONSTRAINT fk_paciente_id FOREIGN KEY (paciente_id) REFERENCES pacientes (id) ON UPDATE CASCADE ON DELETE CASCADE; -- Añadir la FK correspondiente
ALTER TABLE visitas ADD CONSTRAINT fk_medico_id FOREIGN KEY (medico_id) REFERENCES medicos (id) ON UPDATE CASCADE ON DELETE CASCADE; -- Añadir la FK correspondiente
SET SQL_SAFE_UPDATES = 1;

-- 4. Normalización y División de Tablas
START TRANSACTION;
SELECT * FROM pacientes;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE seguros_pacientes (
paciente_id INT,
num_poliza VARCHAR(50),
estado_poliza ENUM('ACTIVA','INACTIVA') DEFAULT 'ACTIVA',
CONSTRAINT pk_paciente_id PRIMARY KEY (paciente_id),
CONSTRAINT fk2_paciente_id FOREIGN KEY (paciente_id) REFERENCES pacientes (id) ON UPDATE CASCADE ON DELETE CASCADE
); -- Crear la nueva tabla
INSERT INTO seguros_pacientes (paciente_id, num_poliza) SELECT id, num_poliza FROM pacientes WHERE num_poliza IS NOT NULL; -- Instaurar los datos de num_poliza a la tabla nueva creada
ALTER TABLE pacientes DROP COLUMN num_poliza;
SELECT * FROM seguros_pacientes;
SET SQL_SAFE_UPDATES = 1;

-- 5. Columnas Calculadas y Blindaje
SELECT * FROM visitas;
SET SQL_SAFE_UPDATES = 0;
UPDATE visitas SET importe_sucio = TRIM(REPLACE(importe_sucio,',','.')); -- Cambios en el formato (quitar espacios sobrantes y cambiar , por .)
UPDATE visitas SET importe_sucio = REPLACE(importe_sucio,'$','') WHERE importe_sucio LIKE ('%$%'); -- Cambios en el formato (quitar €)
UPDATE visitas SET importe_sucio = REPLACE(importe_sucio,'€','') WHERE importe_sucio LIKE ('%€%'); -- Cambios en el formato (quitar $)
UPDATE visitas SET importe_sucio = REPLACE(importe_sucio,'EUR','') WHERE importe_sucio LIKE ('%EUR%'); -- Cambios en el formato (quitar EUR)
UPDATE visitas SET importe_sucio = REPLACE(importe_sucio,'Gratis','0.00') WHERE importe_sucio LIKE ('%Gratis%'); -- Cambios en el formato (cambiar la palabra 'Gratis' por 0.00)
ALTER TABLE visitas MODIFY COLUMN importe_sucio DECIMAL(10,2); -- Cambiar el tipo de dato de la columna importe_sucio
ALTER TABLE visitas ADD COLUMN copago_estimado DECIMAL(10,2); -- Añadiendo la nueva columna a la tabla con el formato indicado
UPDATE visitas SET copago_estimado = 0.2 * importe_sucio; -- Instaurando como se calculan los datos de la nueva columna tras haber saneado la columna importe_sucio
ALTER TABLE seguros_pacientes MODIFY COLUMN num_poliza VARCHAR(50) NOT NULL; -- Establecer como obligatorios los datos
ALTER TABLE visitas MODIFY COLUMN copago_estimado DECIMAL(10,2) NOT NULL; -- Establecer como obligatorios los datos
SET SQL_SAFE_UPDATES = 1;

-- 6. Ingesta de Datos Externos
SELECT * FROM raw_import_visitas;
SELECT * FROM visitas;
SELECT * FROM pacientes;
SET SQL_SAFE_UPDATES = 0;
INSERT IGNORE INTO pacientes (nif, nombre_completo, f_nacimiento)
SELECT 
    SUBSTRING_INDEX(raw_data, '|', 1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 2), '|', -1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 3), '|', -1)
FROM raw_import_visitas; -- Insertar los datos de raw_data extrayendo por '|' a su tabla correspondiente
-- Para poder insertar los números de teléfono primero habrá que sanear los datos de la tabla 
UPDATE pacientes SET tel_contacto = TRIM(REPLACE(tel_contacto,'+34','')) WHERE tel_contacto LIKE ('%+34%'); -- Cambios en el formato (quitar prefijo de país '+34')
UPDATE pacientes SET tel_contacto = REPLACE(REPLACE(tel_contacto,'-',''),' ',''); -- Cambios en el formato (quitar '-' y ' ')
UPDATE pacientes SET tel_contacto = REPLACE(tel_contacto,'0034','') WHERE tel_contacto LIKE ('0034%'); -- Cambios en el formato (quitar prefijo de país '0034')
UPDATE pacientes JOIN raw_import_visitas ON pacientes.nif = SUBSTRING_INDEX(raw_import_visitas.raw_data, '|', 1) SET pacientes.tel_contacto = raw_import_visitas.raw_phone WHERE pacientes.tel_contacto IS NULL; -- Insertamos los teléfonos que no se encuentren en pacientes
-- Para poder insertar los datos del importe_sucio debemos sanearlos, ya que los de la tabla visitas fueron saneados previamente
UPDATE raw_import_visitas SET raw_data = REPLACE(raw_data,'GRATIS','0.00') WHERE raw_data LIKE ('%GRATIS%');  -- Cambios en el formato (quitar 'GRATIS' por 0.00)
UPDATE raw_import_visitas SET raw_data = REPLACE(raw_data,'$','') WHERE raw_data LIKE ('%$%');  -- Cambios en el formato (quitar $)
UPDATE raw_import_visitas SET raw_data = REPLACE(raw_data,'EUR','') WHERE raw_data LIKE ('%EUR%');  -- Cambios en el formato (quitar 'EUR')
UPDATE raw_import_visitas SET raw_data = REPLACE(raw_data,',','.') WHERE raw_data LIKE ('%,%');  -- Cambios en el formato (cambiar ',' por '.')
-- Los espacios sobrantes se quitarán a la hora de importar los datos
UPDATE visitas JOIN raw_import_visitas ON visitas.paciente_id = SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 4), '|', -1) SET importe_sucio = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 4), '|', -1)); -- Importar los datos de importes quitando los espacios sobrantes
SET SQL_SAFE_UPDATES = 1;

-- EXTRA: Saneamiento profundo
-- En este apartado se realizarán los cambios que considero necesarios
SELECT * FROM pacientes;
DESCRIBE pacientes;
SELECT * FROM visitas;
DESCRIBE visitas;
SET SQL_SAFE_UPDATES = 0;
/* Tabla pacientes
Solucionar formato nombres
Solucionar formato correos
Estandarizar las fechas
Poner condiciones y cambiar tipo de dato a las columnas
*/
ALTER TABLE pacientes ADD CONSTRAINT chk_pacientes_nif CHECK (nif REGEXP '^[0-9]{8}[ABCDEFGHJKLMNPQRSTVWXYZ]{1}$'); -- Añadir restricción de formato de nif
UPDATE pacientes SET nombre_completo = TRIM(REPLACE(nombre_completo,'  ',' ')); -- Quitar espacios sobrantes y remplazar espacios dobles entre nombre y apellido
UPDATE pacientes SET nombre_completo = UPPER(nombre_completo); -- Poner nombres en mayúsculas
UPDATE pacientes SET email = REPLACE(REPLACE(email,',','.'),'con','com'); -- Reemplazar ',' por '.' y 'con' por 'com'
UPDATE pacientes SET email = CONCAT(SUBSTRING_INDEX(email, '@', 2),REPLACE(CONCAT('@',SUBSTRING_INDEX(email, '@', -1)), '@', '.')) WHERE email LIKE ('%@%@%'); -- Realizar la conversión del 2º '@' a '.'
ALTER TABLE pacientes ADD CONSTRAINT chk_pacientes_email CHECK (email LIKE '%@%.%');
UPDATE pacientes SET f_nacimiento = CASE
	WHEN f_nacimiento LIKE ('%/%/%') THEN STR_TO_DATE(f_nacimiento, '%d/%m/%Y') 
    WHEN f_nacimiento LIKE ('%.%.%') THEN STR_TO_DATE(f_nacimiento, '%Y.%m.%d')
    WHEN f_nacimiento LIKE ('__-__-____') THEN STR_TO_DATE(f_nacimiento, '%d-%m-%Y')
    WHEN f_nacimiento LIKE ('____-__-__') THEN STR_TO_DATE(f_nacimiento, '%Y-%m-%d')
END; -- Estandarizar todos los formatos de fecha que se encuentran en la tabla pacientes
ALTER TABLE pacientes MODIFY COLUMN f_nacimiento DATE; -- Cambiar el tipo de dato de f_nacimiento a fecha
-- Para poder cambiar el dato de tel_contacto hay que sanear los datos
DELETE FROM pacientes WHERE tel_contacto IS NULL OR LENGTH(tel_contacto) != 9; -- Borrar a los clientes sin tel_contacto o un formato incorrecto
ALTER TABLE pacientes MODIFY COLUMN tel_contacto CHAR(9) NOT NULL; -- Poner tamaño de exactamente 9 caracteres y que sea obligatorio
 /* Tabla visitas
Estandarizar las fechas
Poner condiciones y cambiar tipo de dato a las columnas
*/
UPDATE visitas  SET fecha_visita = CASE
	WHEN fecha_visita LIKE ('%/%/%') THEN STR_TO_DATE(fecha_visita, '%d/%m/%Y %H:%i') 
    WHEN fecha_visita LIKE ('%.%.%') THEN STR_TO_DATE(fecha_visita, '%Y.%m.%d %H:%i')
    WHEN fecha_visita LIKE ('__-__-____%') THEN STR_TO_DATE(fecha_visita, '%d-%m-%Y %H:%i')
END; -- Estandarizar todos los formatos de fecha que se encuentran en la tabla visitas
ALTER TABLE visitas MODIFY COLUMN fecha_visita DATETIME; -- Cambiar el tipo de dato de fecha_visita a fecha real
ALTER TABLE visitas MODIFY COLUMN paciente_id INT NOT NULL; -- Hacer que la columna paciente_id sea obligatoria
ALTER TABLE visitas MODIFY COLUMN medico_id INT NOT NULL; -- Hacer que la columna medico_id sea obligatoria
SET SQL_SAFE_UPDATES = 1;
