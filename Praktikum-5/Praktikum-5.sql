USE classicmodels;

# Nomor 1
SELECT DISTINCT c.customerName AS `namaKustomer`, p.productName AS `namaProduk`, pl.textDescription AS `textDescription`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber

JOIN orderdetails od
ON o.orderNumber = od.orderNumber

JOIN products p
ON od.productCode = p.productCode

JOIN productlines pl
ON p.productLine = pl.productLine

WHERE productName LIKE '%Titanic%'
ORDER BY namaKustomer;


# Nomor 2
SELECT c.customerName, p.productName, o.status, o.shippedDate
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber

JOIN orderdetails od
ON o.orderNumber = od.orderNumber

JOIN products p
ON od.productCode = p.productCode

WHERE 
	p.productName LIKE '%Ferrari%' AND
	STATUS = 'Shipped' AND 
	o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;


# Nomor 3
SELECT
	CONCAT(s.firstName, ' ', s.lastName) AS `Supervisor`,
	CONCAT(e.firstName, ' ', e.lastName) AS `Karyawan`
FROM employees s
JOIN employees e
ON s.employeeNumber = e.reportsTo

WHERE s.firstName = 'Gerard' OR s.lastName = 'Gerard'
ORDER BY `Karyawan`;


# Nomor 4
# a
SELECT c.customerName, pay.paymentDate, CONCAT(e.firstName, ' ', e.lastName) AS `employeeName`, pay.amount
FROM customers c
JOIN payments pay
ON c.customerNumber = pay.customerNumber

JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber

WHERE MONTH(pay.paymentDate) = 11;

# b
SELECT c.customerName, pay.paymentDate, CONCAT(e.firstName, ' ', e.lastName) AS `employeeName`, pay.amount
FROM customers c
JOIN payments pay
ON c.customerNumber = pay.customerNumber

JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber

WHERE MONTH(pay.paymentDate) = 11
ORDER BY amount DESC
LIMIT 1;

# c
SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber

JOIN orderdetails od
ON o.orderNumber = od.orderNumber

JOIN products p
ON od.productCode = p.productCode

JOIN payments pay
ON c.customerNumber = pay.customerNumber

WHERE MONTH(pay.paymentDate) = 11 AND c.customerName = 'Corporate Gift Ideas Co.';


# Soal Tambahan
SELECT c.customerName, o.orderNumber, o.orderDate, o.shippedDate, p.productName, od.quantityOrdered, od.priceEach, ofc.city, e.firstName, e.lastName
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices ofc
ON e.officeCode = ofc.officeCode
WHERE 
	p.productName LIKE '%69%' AND 
	ofc.city IN ('Paris', 'London') AND   
	od.priceEach > 70
ORDER BY od.quantityOrdered DESC;