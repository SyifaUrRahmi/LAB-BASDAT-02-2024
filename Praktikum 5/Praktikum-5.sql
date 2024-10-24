SELECT DISTINCT c.customerName AS 'namaKustomer', p.productName AS 'namaProduk', pl.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;

SELECT c.customerName, p.productName, o.`status`, o.shippedDate
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
WHERE 
	p.productName LIKE '%Ferrari%' 
	AND `status` = 'Shipped' 
	AND (shippedDate BETWEEN '2003-10-01' AND '2004-10-01')
ORDER BY shippeddate DESC;

SELECT 
	e.firstName AS 'Supervisor',
	m.firstName AS 'Karyawan'
FROM employees e
JOIN employees m
ON e.employeeNumber = m.reportsTo
WHERE e.firstName LIKE '%gerard%'
ORDER BY m.firstName;

SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName', p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11%'


SELECT c.customerName, p.paymentDate, e.firstName AS 'employeeName', p.amount
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11%'
ORDER BY p.amount DESC 
LIMIT 1;

SELECT c.customerName, pr.productName
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products pr
ON od.productCode = pr.productCode
WHERE c.customerName = 'Corporate Gift Ideas Co.';

SELECT 
	c.customerName, 
	o.orderNumber, 
	o.orderDate, 
	o.shippedDate, 
	p.productName,
	od.quantityOrdered,
	od.priceEach,
	c.city,
	e.firstName,
	e.lastName
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices `of`
ON e.officeCode = `of`.officeCode
WHERE 
	p.productName LIKE '%69%'  
	AND `of`.city IN ('Paris','London')
	AND od.priceEach > 70;
	


 
 	


