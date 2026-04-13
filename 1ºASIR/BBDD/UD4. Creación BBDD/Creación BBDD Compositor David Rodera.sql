DROP DATABASE IF EXISTS discosEjercicio5Relacional;
CREATE DATABASE discosEjercicio5Relacional;
USE discosEjercicio5Relacional;

CREATE TABLE compositor (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(5,0),
    nacionalidad VARCHAR(4),
    CONSTRAINT pk_compositor PRIMARY KEY (id)
);


CREATE TABLE obra (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    tipo VARCHAR(50),
    tonalidad ENUM('DoMayor', 'Domenor', 'Do#Mayor', 'Do#menor', 'RebMayor', 'Rebmenor', 'ReMayor', 'Remenor', 'Re#Mayor', 'Re#menor', 'MibMayor', 'Mibmenor', 'MiMayor', 'Mimenor', 'FaMayor', 'Famenor', 'Fa#Mayor', 'Fa#menor', 'SolbMayor', 'Solbmenor', 'SolMayor', 'Solmenor', 'Sol#Mayor', 'Sol#menor', 'LabMayor', 'Labmenor', 'LaMayor', 'Lamenor', 'La#Mayor', 'La#menor', 'SibMayor', 'Sibmenor', 'SiMayor', 'Simenor'),
    modo VARCHAR(50),
    id_compositor TINYINT UNSIGNED,
    PRIMARY KEY (id),
    CONSTRAINT fk_obra_compositor FOREIGN KEY (id_compositor)
        REFERENCES compositor (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE director (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(5,0),
    nacionalidad VARCHAR(4),
    CONSTRAINT pk_director PRIMARY KEY (id)
);

CREATE TABLE interprete (
    id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(5,0),
    nacionalidad VARCHAR(4),
    CONSTRAINT pk_interprete PRIMARY KEY (id)
);

CREATE TABLE version (
    id_version TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_obra TINYINT UNSIGNED NOT NULL,
    id_director TINYINT UNSIGNED,
    id_interprete TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_version PRIMARY KEY (id_version),
    CONSTRAINT fk_id_obra FOREIGN KEY (id_obra)
        REFERENCES obra (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_id_director FOREIGN KEY (id_director)
        REFERENCES director (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_id_interprete FOREIGN KEY (id_interprete)
        REFERENCES interprete (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
