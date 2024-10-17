USE classicmodels;

SELECT c.customerName, CONCAT(e.firstName, ' ', e.lastName) AS salesRep, c.creditLimit - SUM(p.amount) AS `remainingCredit`
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.customerName
HAVING `remainingCredit` > 0;

SELECT p.productName AS `Nama Produk`, GROUP_CONCAT(DISTINCT c.customerName SEPARATOR ', ') AS `Nama Customer` , COUNT(DISTINCT c.customerName) AS `Jumlah Customer`, SUM(od.quantityOrdered) AS `Total Kuantitas`
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
GROUP BY p.productName;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS `employeeName`, COUNT(c.customerName) AS `totalCustomers`
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC;

SELECT CONCAT
	(e.firstName, ' ', e.lastName) AS `Nama Karyawan`, 
	p.productName AS `Nama Produk`, 
	SUM(od.quantityOrdered) AS `Jumlah Pesanan`
FROM employees AS e
LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders AS o USING (customerNumber)
LEFT JOIN orderdetails AS od USING (orderNumber)
LEFT JOIN products AS p USING (productCode)
LEFT JOIN offices AS ofs USING (officeCode)
WHERE ofs.country = 'Australia'
GROUP BY `Nama Karyawan`, `Nama Produk`
ORDER BY `Jumlah Pesanan` DESC;

SELECT 
	c.customerName AS `Nama Pelanggan`, 
	GROUP_CONCAT(DISTINCT p.productName SEPARATOR ', ') AS `Nama Produk`,
	COUNT(DISTINCT p.productCode) AS `Banyak Jenis Produk`
FROM customers AS c 
JOIN orders AS o USING (customerNumber) 
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
JOIN productlines AS pd USING (productLine)
WHERE o.shippedDate IS NULL
GROUP BY `Nama Pelanggan`
ORDER BY `Nama Pelanggan`;

SELECT c.customerName AS `Nama Kustomer`, GROUP_CONCAT(DISTINCT p.productName) AS `Nama Produk`, GROUP_CONCAT(DISTINCT CONCAT(e.firstName, ' ', e.lastName) SEPARATOR ', ') AS `Nama Karyawan`
FROM customers AS c 
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS p USING (productCode)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.customerName;