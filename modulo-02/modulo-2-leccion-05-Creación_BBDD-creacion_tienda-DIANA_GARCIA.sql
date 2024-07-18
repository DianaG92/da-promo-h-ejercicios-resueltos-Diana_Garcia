-- EJERCICIOS DE SQL CREACIÓN BBDD --

CREATE SCHEMA creacion_tienda;
USE creacion_tienda;

-- Ejercicio 4: Ejercicio 4: Crea la tabla customers (sin tener en cuenta claves foráneas relacionadas con la tabla Employees).
CREATE TABLE customers (
customernumber INT NOT NULL PRIMARY KEY,
customername VARCHAR(50),
contactlastname VARCHAR(50),
contactfirstname VARCHAR(50),
phone VARCHAR(50),
addressline1 VARCHAR(100),
addressline2 VARCHAR(100),
city VARCHAR(50),
state VARCHAR(50),
postalcode VARCHAR(15),
country VARCHAR(50),
salesrepemployeeNumber INT,
creditlimit FLOAT(2)
);

-- Ejercicio 5: Crea la tabla employees (sin tener en cuenta claves foráneas relacionadas con la tabla Customers).
CREATE TABLE employees (
id_empoloyee INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50),
apellido VARCHAR(50),
email VARCHAR(100),
telefono VARCHAR(20),
fecha_contratacion DATE,
puesto VARCHAR(100),
departamento VARCHAR(100),
salario FLOAT(2),
id_manager INT
);

-- Ejercicio 6: Crea de nuevo las dos tablas (con un nombre diferente a las dos creadas anteriormente) teniendo en cuenta las claves foráneas y restricciones para los datos (por ejemplo que el límite de crédito nunca sea negativo... Todo lo que se te ocurra).
CREATE TABLE customers2 (
    id_costumer2 INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(100),
    codigo_popstal VARCHAR(10),
    ciudad VARCHAR(50),
	pais VARCHAR(50),
    limite_credito FLOAT(2)
    CONSTRAINT limite_credito CHECK (limite_credito >= 0)
);

CREATE TABLE employees2 (
    id_employee INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_contratacion DATE,
    puesto VARCHAR(100),
    departmento VARCHAR(100),
    salario FLOAT(3),
    id_manager INT,
    FOREIGN KEY (id_manager) REFERENCES employees2 (id_employee),
    CONSTRAINT salario CHECK (salario >= 0)
);

-- BONUS: Crea las tablas con la estructura que definiste en el ejercicio de la clase invertida de ayer, que cumpla con las normas de normalización.
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

CREATE TABLE articulos (
    id_articulo INT NOT NULL PRIMARY KEY,
    articulo VARCHAR(50),
    marca VARCHAR(50),
    precio_unitario FLOAT(2)
);

CREATE TABLE pedidos (
    id_pedido INT NOT NULL PRIMARY KEY,
    id_usuario INT,
    id_articulo INT,
    cantidad INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_articulo) REFERENCES articulos(id_articulo)
);