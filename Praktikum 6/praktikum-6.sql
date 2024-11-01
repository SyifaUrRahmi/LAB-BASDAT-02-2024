-- nomor 1
SELECT c.customerName, 
CONCAT(e.firstName, " ", e.lastName) 
AS salesRep, c.creditLimit - SUM(p.amount)
AS remainingCredit
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit > 0;

-- nomor 2
SELECT 
		 p.productName AS 'Nama Produk', 
		 GROUP_CONCAT(DISTINCT c.customerName) AS 'Nama Customer',
		 COUNT(DISTINCT c.customerNumber) AS 'Jumlah Customer',
		 SUM(od.quantityOrdered) AS 'Total Quantitas'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY p.productName;

-- nomor 3
SELECT 
		 CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
		 COUNT(c.customerNumber) AS totalCustomers
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;
-- SELECT employeeNumber FROM employees
-- SELECT COUNT(*) AS karyawan FROM employees

-- nomor 4
SELECT 
		 CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan',
		 c.customerName AS 'Nama Produk',
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
JOIN offices k
USING(officeCode)
WHERE k.country = 'Australia'
GROUP BY employeeNumber
ORDER BY SUM(od.quantityOrdered) DESC;

-- nomor 5
SELECT 
		 c.customerName AS 'Nama Pelanggan',
		 GROUP_CONCAT(DISTINCT p.productName) AS 'Nama Produk',
		 COUNT(p.productCode) AS 'Banyak Jenis Produk'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
WHERE o.shippedDate IS NULL 
GROUP BY c.customerName;

-- soal tambahan
SELECT
		 c.customerName AS 'nama pelanggan',
		 GROUP_CONCAT(p.productName) AS 'produk',
		 GROUP_CONCAT(DISTINCT(CONCAT(e.firstName, ' ', e.lastName))) AS 'karyawan'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.customerName;

