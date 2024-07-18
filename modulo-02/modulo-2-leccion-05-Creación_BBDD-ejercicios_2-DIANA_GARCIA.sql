-- EJERCICIOS DE SQL CREACIÓN BBDD --

CREATE SCHEMA ejercicios_2;
USE ejercicios_2;

-- Ejercicio 2: Modifica la siguiente tabla, pero añadiendo una restricción de tabla que comprueba si la edad de la persona es mayor de 16 años. Llámala Personas2:
CREATE TABLE personas (
    id INT NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    edad INT CHECK (edad > 16),
    ciudad VARCHAR(255) DEFAULT 'Madrid'
);

-- Ejercicio 3: Crea las tabla Empleadas y empleadas_en_proyectos, definiendo claves primarias, claves foránea, tipos de datos, etc. Haz que cuando se elimine una Empleada, se eliminen todas las entradas en empleadas_en_proyectos asociadas.
CREATE TABLE empleadas (
id_empleada INT AUTO_INCREMENT PRIMARY KEY,
salario FLOAT,
nombre VARCHAR(50),
apellido VARCHAR(50),
pais VARCHAR(50)
);

CREATE TABLE empleadas_en_proyectos (
id_empleada INT NOT NULL,
id_proyecto INT NOT NULL,
PRIMARY KEY (id_empleada, id_proyecto),
FOREIGN KEY (id_empleada)
REFERENCES empleadas (id_empleada)
ON DELETE CASCADE
ON UPDATE CASCADE
);