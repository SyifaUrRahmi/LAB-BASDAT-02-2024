-- NOMOR 1
SELECT 
    customers.customerName,
    CONCAT(employees.firstName, ' ', employees.lastName) AS salesRep,
    customers.creditLimit - SUM(payments.amount) AS remainingCredit
FROM customers
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING(customerNumber)
GROUP BY customers.customerName
HAVING remainingCredit > 0

-- NOMOR 2
SELECT
	products.productName AS `Nama Produk`,
	GROUP_CONCAT(distinct customers.customerName) AS `Nama Kustomer`,
	COUNT(DISTINCT customers.customerNumber) AS `Jumlah Customer`,
	SUM(orderdetails.quantityOrdered) AS `Total Quantitas`
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
JOIN orders
ON orderdetails.orderNumber = orders.orderNumber
JOIN customers
ON orders.customerNumber = customers.customerNumber
GROUP BY `Nama Produk`
	
-- NOMOR 3
SELECT
	CONCAT(employees.firstName, ' ', employees.lastName) AS employeeName,
	COUNT(customers.customerNumber) AS totalCustomers
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomers DESC 

SELECT 
	COUNT(*) AS `Jumlah Karyawan`
FROM employees

	
-- NOMOR 4
SELECT 
	CONCAT(employees.firstName, ' ', employees.lastName) AS `Nama Karyawan`,
	products.productName AS `Nama Produk`,
	SUM(orderdetails.quantityOrdered) AS `Jumlah Pesanan`
FROM employees
left JOIN offices
ON employees.officeCode = offices.officeCode
left JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN orders
ON customers.customerNumber = orders.customerNumber
LEFT JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
left JOIN products
ON orderdetails.productCode = products.productCode
WHERE offices.country = 'Australia'
GROUP BY `Nama Karyawan`, `Nama Produk`
ORDER BY `Jumlah Pesanan` DESC 

-- NOMOR 5
SELECT 
	customers.customerName AS `Nama Pelanggan`,
	group_concat(products.productName) AS `Nama Produk`,
	COUNT(products.productCode) AS `Banyak Jenis Produk`
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
ON orderdetails.productCode = products.productCode
WHERE orders.shippedDate IS NULL 
GROUP BY `Nama Pelanggan`

SELECT
	customers.customerName AS `Nama Pelanggan`,
	group_concat(distinct products.productName) AS `Nama Produk`,
	group_concat(DISTINCT(CONCAT(employees.firstName, ' ', employees.lastName))) AS `Nama Karyawan`
	
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
GROUP BY `Nama Pelanggan`                




	
	