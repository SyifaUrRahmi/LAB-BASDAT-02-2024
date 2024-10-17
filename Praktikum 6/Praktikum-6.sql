#Nama : An Naura Erwana Dwi Putri
#Nim : H071231051

SELECT 
	c.customerName,
	CONCAT(e.firstName, " ", e.lastName) AS 'salesRep',
	(c.creditLimit -  SUM(p.amount)) AS 'remainingCredit'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;


SELECT 
	p.productName AS 'Nama Produk',
	GROUP_CONCAT(c.customerName ORDER BY c.customerName ASC SEPARATOR ', ') AS 'Nama Customer',
	COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
	SUM(od.quantityOrdered) AS 'Total quantitas'
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY p.productName;

SELECT 
	CONCAT(e.firstName, " ", e.lastName) AS 'employeeName',
	COUNT(DISTINCT c.customerNumber) AS 'totalCustomers'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY  employeeName
ORDER BY totalCustomers DESC;


SELECT 
	CONCAT(e.firstName, " ", e.lastName) AS 'Nama Karyawan',
	p.productName AS 'Nama Produk',
	SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
JOIN customers c
USING(customerNumber)
RIGHT JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices `of`
USING(officeCode)
WHERE `of`.country = 'Australia'
GROUP BY  `Nama Produk`, e.employeeNumber
ORDER BY `Jumlah Pesanan` DESC;

SELECT 
	c.customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(DISTINCT p.productName SEPARATOR ', ') AS 'Nama Produk', 
	COUNT(p.productCode) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN  orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerNumber
ORDER BY c.customerName;

#soal tambahan

SELECT 
	c.customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
	GROUP_CONCAT(DISTINCT CONCAT(e.firstName, " ", e.lastName)) AS 'Nama Karyawan'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customerName

