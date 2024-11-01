-- nomor 1
SELECT DISTINCT 
	customerName AS namaKustomer,
	productName AS namaProduk, 
	productDescription AS textDescription  
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE '%Titanic%' 
ORDER BY customers.customerName

-- nomor 2
SELECT
	customers.customerName,
	products.productName,
	orders.`status`,
	orders.shippedDate
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE products.productName LIKE '%Ferrari%'
AND
orders.`status` = 'Shipped'
AND
orders.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY orders.shippedDate DESC 

-- nomor 3
SELECT
	supervisor.firstName AS Supervisor,
	employees.firstName AS Karyawan
FROM employees 
JOIN employees AS supervisor
ON employees.reportsTo = supervisor.employeeNumber
WHERE supervisor.firstName = 'Gerard'
ORDER BY employees.firstName

-- nomor 4 a
SELECT 
	customers.customerName,
	-- customers.customerNumber,
	payments.paymentDate,
	employees.firstName AS employeeName,
	payments.amount
FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE payments.paymentDate LIKE '20__-11-__'
-- nomor 4 b
ORDER BY payments.amount DESC 
LIMIT 1

-- nomor 4 c
SELECT
	customers.customerName,
	products.productName
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
JOIN payments
ON customers.customerNumber = payments.customerNumber
WHERE payments.paymentDate LIKE '20__-11-__'
AND
customers.customerNumber = 321 

SELECT 
	customers.customerName,
	orders.orderNumber,
	orders.orderDate,
	orders.shippedDate,
	products.productName,
	orderdetails.quantityOrdered,
	orderdetails.priceEach,
	offices.city AS officeCity,
	employees.firstName AS salesRepFirstName,
	employees.lastName AS salesRepFirstName
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON products.productCode = orderdetails.productCode
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
ON employees.officeCode = offices.officeCode
WHERE products.productName LIKE '1%r'
AND
orderdetails.quantityOrdered > 10
AND customers.city = 'NYC'
AND orderdetails.priceEach BETWEEN 20 AND 100
ORDER BY customers.customerName, orders.orderDate DESC 

	
	




