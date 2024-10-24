SELECT customerName, 
   CONCAT(e.firstName, ' ', e.lastName) as salesRep,
   (creditLimit - sum(amount)) as remainingCredit
FROM customers as c
JOIN payments as p
   USING (customerNumber)
JOIN employees as e
   ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY customerName
HAVING remainingCredit > 0;

SELECT productName as `Nama Produk`,
   GROUP_CONCAT(DISTINCT customerName SEPARATOR ',') as `Nama Customer`,
   COUNT(DISTINCT customerName) as `Jumlah Customer`,
   SUM(quantityOrdered) as `Total Quantitas`
FROM products as p
JOIN orderdetails as od
   USING (productCode)
JOIN orders as o
   USING (orderNumber)
JOIN customers as c
   USING (customerNumber)
GROUP BY productName
ORDER BY `Nama Produk`;

SELECT CONCAT(e.firstName, ' ', e.lastName) as `employeeName`,
   COUNT(DISTINCT customerName) as `Total Customer`
FROM employees as e
JOIN customers as c
   ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY `Total Customer` DESC;

SELECT * FROM employees;

SELECT CONCAT(e.firstName, ' ', e.lastName) as `Nama Karyawan`,
   productName as `Nama Produk`,
   SUM(quantityOrdered) as `Jumlah Pesanan`
FROM products as p
JOIN orderdetails as od
   USING (productCode)
JOIN orders as o
   USING (orderNumber)
JOIN customers as c
   USING (customerNumber)
RIGHT JOIN employees as e
   ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS of
	USING (officeCode)
WHERE of.country = 'Australia'
GROUP BY `Nama Produk`, `Nama Karyawan`
ORDER BY `Jumlah Pesanan` DESC;

SELECT 
   DISTINCT c.customerName AS `Nama Pelanggan`, 
   GROUP_CONCAT(DISTINCT p.productName ORDER BY p.productName SEPARATOR ', ') AS `Nama Produk`, 
   COUNT(DISTINCT p.productName) AS `Banyak Jenis Produk`
FROM customers AS c
JOIN orders AS o
   USING(customerNumber)
JOIN orderdetails AS od
   USING(orderNumber)
JOIN products AS p
   USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerNumber 
ORDER BY c.customerName ;


SELECT customerName as `Nama Pelanggan`,
    GROUP_CONCAT(DISTINCT productName SEPARATOR ', ') as `Nama Produk`,
    GROUP_CONCAT(DISTINCT CONCAT(e.firstname , ' ', e.lastname) SEPARATOR ', ') as `Nama Karyawan`
FROM customers as c
JOIN orders as o
    USING (customerNumber)
JOIN orderdetails as od
    USING (orderNumber)
JOIN products as p
    USING (productCode)
JOIN employees as e
    ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY customerName;
