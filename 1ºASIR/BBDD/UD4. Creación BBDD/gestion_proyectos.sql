drop database if exists  gestion_proyectos;
CREATE DATABASE gestion_proyectos;
USE gestion_proyectos;

CREATE TABLE empleados (
    id_empleado INT UNSIGNED AUTO_INCREMENT,
    dni VARCHAR(9) UNIQUE NOT NULL,
    salario DECIMAL(7,2) DEFAULT 1200.00,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    CONSTRAINT pk_id_empleado PRIMARY KEY (id_empleado)
);

CREATE TABLE proyectos (
    id_proyecto INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    id_departamento INT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    CONSTRAINT pk_id_proyecto PRIMARY KEY (id_proyecto),
    CONSTRAINT chk_fecha_fin_mayor_fecha_inicio CHECK (fecha_fin > fecha_inicio)
);

CREATE TABLE asignaciones (
    id_empleado INT UNSIGNED,
    id_proyecto INT UNSIGNED,
    horas_asignadas DECIMAL(5,0),
    PRIMARY KEY (id_empleado, id_proyecto),
    CONSTRAINT fk_id_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleados (id_empleado)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_id_proyecto FOREIGN KEY (id_proyecto)
        REFERENCES proyectos (id_proyecto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE departamentos (
    id_departamento INT UNSIGNED,
    codigo_dpto VARCHAR(5) UNIQUE NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    presupuesto DECIMAL(7,2) NOT NULL,
    CONSTRAINT pk_id_departamento PRIMARY KEY (id_departamento),
    CONSTRAINT chk_presupuesto_no_negativo CHECK (presupuesto >= 0)
);
    
ALTER TABLE proyectos 
    ADD CONSTRAINT fk_id_departamento FOREIGN KEY (id_departamento)
        REFERENCES departamentos (id_departamento)
        ON DELETE RESTRICT ON UPDATE CASCADE;






