-- EJERCICIOS DE SQL MODIFICACIÓN E INSERCIÓN DE DATOS --

CREATE SCHEMA insercion_datos;
USE insercion_datos;

CREATE TABLE t1 (a INTEGER, b CHAR(10));

-- 1. Renombra la tabla t1 a t2.
ALTER TABLE t1 RENAME TO t2;

-- 2. Cambia la columna a de tipo INTEGER a tipo TINYINT NOT NULL (manteniendo el mismo nombre para la columna).
ALTER TABLE t2 MODIFY COLUMN a TINYINT NOT NULL;

-- 3. Cambia la columna b de tipo CHAR de 10 caracteres a CHAR de 20 caracteres. Además, renombra la columna como c.
ALTER TABLE t2 MODIFY COLUMN b CHAR(20);
ALTER TABLE t2 CHANGE COLUMN b c CHAR(20);

-- 4. Añade una nueva columna llamada d de tipo TIMESTAMP.
ALTER TABLE t2 ADD COLUMN d TIMESTAMP;

-- 5. Elimina la columna c que definiste en el ejercicio 3.
ALTER TABLE t2 DROP COLUMN c;

-- 6. Crea una tabla llamada t3 idéntica a la tabla t2 (de manera automática, no definiéndola columna a columna).
CREATE TABLE t3 LIKE t2;

-- 7. Elimina la tabla original t2 y en otra sentencia renombra la tabla t3 como t1.
DROP TABLE t2;
ALTER TABLE t3 RENAME TO t1;

-- 8. Para los siguientes ejercicios vamos a usar las tablas ya creadas llamadas customers (clientes/as) y employees, que están en la base de datos tienda.
CREATE TABLE IF NOT EXISTS customers_mod 
SELECT * 
FROM tienda.customers;

-- Realiza una inserción de datos sobre la tabla customers introduciendo la siguiente información.
INSERT INTO customers_mod (customernumber, customername, contactlastname, contactfirstname, phone, addressline1, addressline2, city, state, postalcode, country, salesrepemployeenumber, creditlimit) 
VALUES (343, 'Adalab', 'Rodriguez', 'Julia', '672986373', 'Calle Falsa 123', 'Puerta 42', 'Madrid', 'España', '28000', 'España', 15, 20000000);

-- Introduce ahora 5 filas nuevas con la información que consideres relevante para los campos disponibles en una misma instrucción. Se recuerda que el Indice(=la clave primaria), no es necesaria especificarla. En 3 de las nuevas filas debes dejar vacio el campo 'contactFirstName'.
INSERT INTO customers_mod (customernumber, customername, contactlastname, contactfirstname, phone, addressline1, addressline2, city, state, postalcode, country, salesrepemployeeNumber, creditlimit) 
VALUES (345, 'Cliente 1', 'Apellido1', 'Nombre1', '11111111', 'Calle 1', 'Piso 1', 'Ciudad 1', 'Estado 1', '11111', 'País 1', 12, 10000),
       (346, 'Cliente 2', 'Apellido2', '', '22222222', 'Calle 2', 'Piso 2', 'Ciudad 2', 'Estado 2', '22222', 'País 2', 13, 20000),
       (347, 'Cliente 3', 'Apellido3', '', '33333333', 'Calle 3', 'Piso 3', 'Ciudad 3', 'Estado 3', '33333', 'País 3', 14, 30000),
       (348, 'Cliente 4', 'Apellido4', 'Nombre4', '44444444', 'Calle 4', 'Piso 4', 'Ciudad 4', 'Estado 4', '44444', 'País 4', 15, 40000),
       (349, 'Cliente 5', 'Apellido5', '', '55555555', 'Calle 5', 'Piso 5', 'Ciudad 5', 'Estado 5', '55555', 'País 5', 16, 50000);
       
-- Actualiza ahora los datos faltantes correspondientes al CustomerName 'La pegatina After' con la siguiente información.
UPDATE customers_mod 
SET addressline1 = 'Polígono Industrial de Son Castelló',
    addressline2 = 'Nave 92',
    city = 'Palma de Mallorca',
    state = 'España',
    postalcode = '28123',
    country = 'España',
    salesrepemployeeNumber = 25,
    creditlimit = 5000000
WHERE customername = 'La pegatina After';

-- Una vez creada la copia y guardada a buen recaudo, vamos a actualizar algunos de los cambios sin especificar la condición del WHERE. Para ello modifica el campo los siguientes campos.
UPDATE customers_mod
SET addressline1 = 'Vamos',
    addressline2 = 'a',
    postalcode = 'fastidiar',
    country = 'la tabla :)';
    
-- Tras esto restaura la tabla que has trasteado con la copia que te has creado previamente.
DROP TABLE customers_mod;
CREATE TABLE customers AS
SELECT * FROM customers_destroy;

-- Actualiza ahora los datos de la tabla customers_mod, para que las 10 primeras empresas sean gestionadas por la representante de ventas numero 2. El resto de empresas no deben ser modificadas.
/* COPIADO DE INTERNET PORQUE NO SABIA CÓMO HACERLO */
UPDATE customers
SET salesrepemployeeNumber = 2
WHERE customernumber IN (
    SELECT customernumber
    FROM (
        SELECT customernumber, ROW_NUMBER() OVER (ORDER BY customernumber) AS rownum
        FROM customers
    ) AS numberedrows
    WHERE rownum <= 10
);

-- Queremos ahora eliminar de los datos de la tabla aquellos registros que contengan un 'null' en el campo 'ContactFirstName'.
DELETE FROM customers
WHERE contactfirstname IS NULL;

-- Ejecuta la instrucción de DELETE para la tabla customers_mod olvidando el WHERE como condición. Y observa lo que ha ocurrido.
DELETE FROM customers_mod;