SELECT DISTINCT customerName as namaKustomer,
    productName as namaProduk,
    productDescription as textdescription
FROM customers as c
JOIN orders as o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails as od
    ON o.orderNumber = od.orderNumber
JOIN products as p
    ON od.productCode = p.productCode
WHERE p.productName LIKE '%titanic%';

SELECT 
    p.productName as namaProduk,
    c.customerName as namaKostumer,
    o.status,
    o.shippedDate
FROM customers as c
JOIN orders as o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails as od
    ON o.orderNumber = od.orderNumber
JOIN products as p
    ON od.productCode = p.productCode
WHERE p.productName LIKE '%ferrari%'
    AND o.status = 'Shipped'
    AND o.shippedDate BETWEEN '2003-10-01' AND '2004-09-30'
ORDER BY o.shippedDate DESC;

SELECT 
    s.firstName as Supervisor,
    e.firstName as Karyawan
FROM employees as e
JOIN employees as s
    ON e.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard';

SELECT DISTINCT
    c.customerName,
    p.paymentDate,
    CONCAT(e.firstName, ' ', e.lastName) as employeeName,
    p.amount
FROM customers as c
JOIN payments as p
    ON c.customerNumber = p.customerNumber
JOIN orders as o
    ON c.customerNumber = o.customerNumber
JOIN employees as e
    ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '%-11-%'
ORDER BY p.amount DESC
LIMIT 1;

SELECT c.customerName,
    p.productName
FROM customers as c
JOIN orders as o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails as od
    ON o.orderNumber = od.orderNumber
JOIN products as p
    ON od.productCode = p.productCode
JOIN payments as pay
    ON c.customerNumber = pay.customerNumber
WHERE c.customerName = 'Corporate Gift Ideas Co.'
    AND pay.paymentDate like '%-11-%';