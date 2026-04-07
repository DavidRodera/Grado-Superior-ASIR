use gha_analytics;

-- 1. Normalización de Identidad (Pacientes)
START TRANSACTION;
SELECT * FROM pacientes;
SET SQL_SAFE_UPDATES = 0;
SELECT nif FROM pacientes GROUP BY nif HAVING COUNT(nif) > 1; -- Comprobar los NIFs duplicados
DELETE p1 FROM pacientes p1 INNER JOIN pacientes p2 ON p1.nif = p2.nif WHERE p1.id > p2.id; -- Eliminar los NIFs duplicados
SELECT * FROM pacientes WHERE NOT (CHAR_LENGTH(nif) = 9 AND nif REGEXP '^[0-9]{8}[A-Z]{1}$'); -- Comprobar los formatos erroneos de NIFs
UPDATE pacientes SET nif = REPLACE(nif,'-',''); -- Quitar '-' de los NIFs
UPDATE pacientes SET nif = TRIM(nif); -- Quitar espacios sobrantes de los NIFs
DELETE p1 FROM pacientes p1 WHERE NOT (CHAR_LENGTH(nif) = 9 AND nif REGEXP '^[0-9]{8}[A-Z]{1}$'); -- Borrar aquellos pacientes cuyos NIFs no cumplan los requisitos y no se puedan arreglar
ALTER TABLE pacientes MODIFY COLUMN nif CHAR(9) UNIQUE NOT NULL; -- Hacer que la columna nif sea única, no este vacía y que su formato sea  una cadena de exactamente 9 caracteres 
SET SQL_SAFE_UPDATES = 1;
ROLLBACK;

-- 2. Consistencia de Colegiados (Médicos)
START TRANSACTION;
SELECT * FROM medicos;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM medicos WHERE NOT (CHAR_LENGTH(num_colegiado) = 11 AND num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}$'); -- Comprobar los formatos erroneos de num_colegiado
UPDATE medicos SET num_colegiado = CONCAT('COL-', num_colegiado) WHERE num_colegiado NOT LIKE 'COL%'; -- Añadir el prefijo 'COL' al inicio de aquellos códigos que no lo contengan
UPDATE medicos SET num_colegiado = REPLACE(num_colegiado,'/','-'); -- Sustituir '/' por '-'
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 4, 0, '-') WHERE num_colegiado NOT LIKE ('___-%'); -- Añadir el '-' después de 'COL' si no hay uno
UPDATE medicos SET num_colegiado = REPLACE(num_colegiado,'INV','99') WHERE num_colegiado LIKE '%INV%';
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 7, 0, '-') WHERE num_colegiado NOT LIKE ('___-__-%'); -- Añadir el '-' después del número de provincia si no hay uno
UPDATE medicos SET num_colegiado = INSERT(num_colegiado, 8, 0, '0') WHERE NOT num_colegiado REGEXP('^COL-[0-9]{2}-[0-9]{4}$'); -- Añadir un número al principio de los número que no poseen 4 carácteres
SET SQL_SAFE_UPDATES = 1;
ROLLBACK; 

-- 3. Integridad Referencial  
START TRANSACTION;
SELECT * FROM medicos;
SELECT * FROM visitas;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM medicos LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id WHERE especialidades.id IS NULL; -- Comprobar médicos sin especialidades
UPDATE medicos LEFT JOIN especialidades ON medicos.especialidad_id = especialidades.id SET medicos.especialidad_id = (SELECT id FROM especialidades WHERE nombre = 'Medicina General') WHERE especialidades.id IS NULL; -- Cambiamos los ids huérfanos en especialidades por el id de 'Medicina General'
DESCRIBE medicos; -- Comprobar si hay FKs
ALTER TABLE medicos ADD CONSTRAINT fk_especialidad_id FOREIGN KEY (especialidad_id) REFERENCES especialidades (id) ON UPDATE CASCADE ON DELETE CASCADE; -- Añadir la FK correspondiente en medicos	


drop database gha_analytics;



