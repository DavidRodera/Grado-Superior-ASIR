create database gestion_universidad;
use gestion_universidad;

CREATE TABLE facultades (
    id_facultad TINYINT UNSIGNED AUTO_INCREMENT,
    codigo CHAR(4) UNIQUE NOT NULL,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    id_decano INT UNSIGNED,
    CONSTRAINT pk_id_facultad PRIMARY KEY (id_facultad),
    CONSTRAINT chk_codigo_longitud CHECK (LENGTH(codigo) = 4)
);

CREATE TABLE profesores (
    id_profesor SMALLINT UNSIGNED AUTO_INCREMENT,
    nif VARCHAR(9) UNIQUE NOT NULL,
    nombre_completo VARCHAR(40) NOT NULL,
    salario DECIMAL(7 , 2 ) DEFAULT 2000.00,
    id_facultad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_profesor PRIMARY KEY (id_profesor),
    CONSTRAINT fk_id_facultad FOREIGN KEY (id_facultad)
        REFERENCES facultades (id_facultad)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_salario_mayor_cero CHECK (salario > 0),
    CONSTRAINT chk_nif_longitud CHECK (LENGTH(nif) = 9)
);

alter table facultades
ADD CONSTRAINT fk_id_decano FOREIGN KEY (id_decano)
        REFERENCES profesores (id_profesor)
        ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE grados (
    id_grado SMALLINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    id_facultad INT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_grado PRIMARY KEY (id_grado),
    CONSTRAINT fk_id_facultad2 FOREIGN KEY (id_facultad)
        REFERENCES facultades (id_facultad)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE asignaturas (
    id_asignatura SMALLINT UNSIGNED AUTO_INCREMENT,
    codigo_asig VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    creditos DECIMAL(2 , 0 ) DEFAULT 6,
    CONSTRAINT chk_creditos_mayor_igual_tres CHECK (creditos >= 3),
    CONSTRAINT chk_codigo_asig_max_longitud CHECK (LENGTH(codigo_asig) <= 10),
    CONSTRAINT pk_id_asignatura PRIMARY KEY (id_asignatura)
);

CREATE TABLE imparten (
    id_profesor SMALLINT UNSIGNED,
    id_asignatura SMALLINT UNSIGNED,
    tipo_grupo ENUM('TEORIA', 'PRACTICA') DEFAULT 'TEORIA',
    PRIMARY KEY (id_profesor , id_asignatura),
    CONSTRAINT fk_id_profesor FOREIGN KEY (id_profesor)
        REFERENCES profesores (id_profesor)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_id_asignatura FOREIGN KEY (id_asignatura)
        REFERENCES asignaturas (id_asignatura)
        ON DELETE CASCADE ON UPDATE CASCADE
);
