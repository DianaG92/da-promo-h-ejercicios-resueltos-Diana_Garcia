-- EJERCICIOS DE SQL SUBCONSULTAS --

USE tienda;

/* EJERCICIO 1:
Calcula el numero de clientes por cada ciudad. */
SELECT city, COUNT(*) AS num_clientes
FROM customers
GROUP BY city;

/* EJERCICIO 2:
Usando la consulta anterior como subconsulta, selecciona la ciudad con el mayor numero de clientes. */
SELECT city, COUNT(*) AS num_clientes
FROM customers
GROUP BY city
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
    FROM customers
    GROUP BY city
    );

/* EJERCICIO 3:
Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido de las clientas asignadas a la ciudad con mayor numero de clientas. */
SELECT customer_number, contact_first_name, contact_last_name
FROM customers
WHERE city = (
    SELECT city
    FROM customers
    GROUP BY city
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

/* EJERCICIO 4:
Queremos ver ahora que empleados tienen algún contrato asignado con alguno de los clientes existentes. 
Para ello selecciona employeeNumber como 'Número empleado', firstName como 'nombre Empleado' y lastName como 'Apellido Empleado'. */
SELECT employee_number AS "Numero empleado", first_name AS "Nombre empleado", last_name AS "Apellido empleado"
FROM employees
WHERE EXISTS (
	SELECT *
    FROM customers
    WHERE customers.sales_rep_employee_number = employees.employee_number
);

/* EJERCICIO 5:
Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes, no también una oficina de nuestra empresa.
Selecciona aquellas ciudades como 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices. */
SELECT city AS "ciudad", customer_name AS "nombre de la empresa"
FROM customers
WHERE NOT EXISTS (
	SELECT *
    FROM offices 
    WHERE customers.city = offices.city
);