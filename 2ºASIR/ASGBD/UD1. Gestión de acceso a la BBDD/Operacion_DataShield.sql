-- ============================================================================
-- PRÁCTICA RA1: OPERACIÓN DATASHIELD
-- Autores: David Rodera - Marco Gallego
-- Asignatura: Administración de Sistemas Gestores de Bases de Datos (ASGBD)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- SECCIÓN 1: CREACIÓN E INICIALIZACIÓN DE LA BASE DE DATOS
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS DataShield_DavidMarco;
CREATE DATABASE DataShield_DavidMarco;
USE DataShield_DavidMarco;


-- ----------------------------------------------------------------------------
-- SECCIÓN 2: CREACIÓN DE TABLAS Y RESTRICCIONES (FOREIGN KEYS)
-- ----------------------------------------------------------------------------

-- Tabla 2.1: Usuarios del sistema
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    rol ENUM('admin_seguridad', 'analista', 'soporte') DEFAULT 'soporte',
    hash_contraseña VARCHAR(50) NOT NULL
);

-- Tabla 2.2: Servidores y sistemas
CREATE TABLE sistemas (
    id_sistema INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sistema VARCHAR(50) NOT NULL,
    ip VARCHAR(15) NOT NULL,
    responsible INT,
    FOREIGN KEY (responsible) REFERENCES usuarios (id_usuario)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

-- Tabla 2.3: Registro de incidencias
CREATE TABLE incidencias (
    id_incidencia INT PRIMARY KEY AUTO_INCREMENT,
    sistema_id INT,
    descripcion VARCHAR(100),
    nivel_gravedad ENUM('baja', 'media', 'alta'),
    estado ENUM('pendiente', 'en curso', 'resuelta'),
    fecha DATE NOT NULL,
    FOREIGN KEY (sistema_id) REFERENCES sistemas (id_sistema)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


-- ----------------------------------------------------------------------------
-- SECCIÓN 3: INSERCIÓN DE DATOS INICIALES
-- ----------------------------------------------------------------------------

-- Inserción en usuarios
INSERT INTO usuarios (nombre, rol, hash_contraseña) VALUES
('Laura Gómez', 'admin_seguridad', 'a3f4c9'),
('Carlos Pérez', 'analista', 'bc97d1'),
('Marta Ruiz', 'soporte', 'ef45aa');

-- Inserción en sistemas
INSERT INTO sistemas (nombre_sistema, ip, responsible) VALUES
('ServidorCorreo', '192.168.10.5', 3),
('WebInstituto', '10.0.0.22', 2);

-- Inserción en incidencias
INSERT INTO incidencias (sistema_id, descripcion, nivel_gravedad, estado, fecha) VALUES
(2, 'Ataque DDoS detectado', 'alta', 'en curso', '2025-10-14'),
(1, 'Fallo en envío de correos', 'media', 'resuelta', '2025-10-10');


-- ----------------------------------------------------------------------------
-- SECCIÓN 4: CREACIÓN DE VISTAS SEGURAS (ABSTRACCIÓN Y SEGURIDAD)
-- ----------------------------------------------------------------------------

-- Vista 4.1: Vista para el perfil Analista (Sin datos sensibles ni IPs)
CREATE VIEW vista_incidencias_analista AS
SELECT
    s.nombre_sistema,
    i.descripcion,
    i.nivel_gravedad,
    i.estado,
    i.fecha
FROM incidencias i
JOIN sistemas s ON i.sistema_id = s.id_sistema;

-- Vista 4.2: Vista de sistemas sin IPs internas
CREATE VIEW vista_sistemas_sin_ip AS
SELECT
    s.id_sistema,
    s.nombre_sistema,
    u.nombre AS responsable
FROM sistemas s
JOIN usuarios u ON s.responsible = u.id_usuario;

-- Vista 4.3: Vista de incidencias para el equipo de Soporte
CREATE VIEW vista_incidencias_soporte AS
SELECT
    i.id_incidencia,
    i.sistema_id,
    s.nombre_sistema,
    i.descripcion,
    i.nivel_gravedad,
    i.estado,
    i.fecha
FROM incidencias i
JOIN sistemas s ON i.sistema_id = s.id_sistema;


-- ----------------------------------------------------------------------------
-- SECCIÓN 5: CREACIÓN DE ROLES, USUARIOS Y ASIGNACIÓN DE PRIVILEGIOS (RBAC)
-- ----------------------------------------------------------------------------

-- 5.1. Creación de Objetos de Rol
CREATE ROLE 'admin_seguridad', 'analista', 'soporte';

-- 5.2. Concesión de Privilegios a los Roles
GRANT ALL PRIVILEGES ON DataShield_DavidMarco.* TO 'admin_seguridad';

GRANT SELECT ON DataShield_DavidMarco.vista_incidencias_analista TO 'analista';
GRANT SELECT ON DataShield_DavidMarco.vista_sistemas_sin_ip TO 'analista';

GRANT SELECT, UPDATE ON DataShield_DavidMarco.vista_incidencias_soporte TO 'soporte';
GRANT SELECT ON DataShield_DavidMarco.vista_sistemas_sin_ip TO 'soporte';

-- 5.3. Creación de Cuentas de Usuario de MariaDB/MySQL
CREATE USER 'user_admin'@'localhost' IDENTIFIED BY 'Admin123*';
CREATE USER 'user_analista'@'localhost' IDENTIFIED BY 'Analista123*';
CREATE USER 'user_soporte'@'localhost' IDENTIFIED BY 'Soporte123*';
CREATE USER 'user_test'@'localhost' IDENTIFIED BY 'Test123*';

-- 5.4. Asignación de Roles a Usuarios y Configuración Predeterminada
GRANT 'admin_seguridad' TO 'user_admin'@'localhost';
SET DEFAULT ROLE 'admin_seguridad' FOR 'user_admin'@'localhost';

GRANT 'analista' TO 'user_analista'@'localhost';
SET DEFAULT ROLE 'analista' FOR 'user_analista'@'localhost';

GRANT 'soporte' TO 'user_soporte'@'localhost';
SET DEFAULT ROLE 'soporte' FOR 'user_soporte'@'localhost';

FLUSH PRIVILEGES;


-- ----------------------------------------------------------------------------
-- SECCIÓN 6: PRUEBAS FUNCIONALES Y VERIFICACIÓN DE SEGURIDAD
-- (Ejecutar conectándose con cada usuario correspondiente)
-- ----------------------------------------------------------------------------

-- Pruebas como 'user_analista':
SELECT * FROM vista_incidencias_analista; -- Funciona correctamente
SELECT * FROM incidencias;                 -- Debe fallar (Acceso denegado)
SELECT ip FROM sistemas;                  -- Debe fallar (Acceso denegado)

-- Pruebas como 'user_soporte':
SELECT * FROM vista_incidencias_soporte WHERE sistema_id IN (1); -- Funciona
UPDATE vista_incidencias_soporte SET estado = 'resuelta' WHERE sistema_id = 1; -- Funciona
DELETE FROM vista_incidencias_soporte WHERE sistema_id = 1; -- Debe fallar
UPDATE sistemas SET ip = '172.0.0.1' WHERE id_sistema = 2;   -- Debe fallar

-- Pruebas de separación de datos como 'user_soporte':
UPDATE vista_incidencias_soporte SET estado = 'resuelta' WHERE sistema_id = 99; -- 0 filas afectadas
SELECT * FROM vista_incidencias_soporte;
