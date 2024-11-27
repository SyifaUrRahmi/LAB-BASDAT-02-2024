-- nomor 1
SELECT DISTINCT customerName AS namaKustomer, 
productName AS namaProduk, textDescription
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN productlines AS pl
USING (productLine)
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName;


-- nomor 2
SELECT c.customerName, p.productName, 
o.`status`, o.shippedDate
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE p.productName LIKE '%Ferrari%' 
AND o.`status` = 'Shipped'
AND o.shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY o.shippedDate DESC;
 
-- nomor 3
SELECT e.firstName AS Supervisor, 
o.firstName AS Karyawan
FROM employees AS e
JOIN employees AS o
ON o.reportsTo = e.employeeNumber
WHERE e.firstName = 'Gerard';
SELECT *FROM employees

-- nomor 4
-- bagian a
SELECT c.customerName, p.paymentDate, 
e.firstName AS employeeName, p.amount
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE p.paymentDate LIKE '%-11-%';

-- bagian b
SELECT c.customerName, p.paymentDate, 
e.firstName AS employeeName, p.amount
FROM payments AS p 
JOIN customers AS c
USING (customernumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC 
LIMIT 1;

-- bagian c
SELECT c.customerName, pr.productName
FROM customers AS c
JOIN payments AS p
USING (customerNumber)
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS pr
USING (productCode)
WHERE c.customerName LIKE 'Corporate Gift Ideas Co.'
AND p.paymentDate LIKE '%-11-%' 


-- soal tambahan
SELECT * FROM products;
SELECT c.customerName AS namaKustomer, 
e.firstName AS namaKaryawan,
p.productName AS namaProduk, p.buyPrice, p.MSRP
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE buyPrice < (0.8 * p.MSRP);