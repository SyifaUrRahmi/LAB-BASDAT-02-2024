-- NOMOR 1
(SELECT 
productName,
SUM(priceEach*quantityOrdered) AS TotalRevenue,
'Pendapatan Tinggi' AS Pendapatan
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE month(orderDate) = 09
GROUP BY productCode
ORDER BY TotalRevenue DESC
LIMIT 5)
UNION
(SELECT 
productName,
SUM(priceEach*quantityOrdered) AS TotalRevenue,
'Pendapatan Rendah' AS Pendapatan
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE month(orderDate) = 09
GROUP BY productCode
ORDER BY TotalRevenue
LIMIT 5)
ORDER BY


-- NOMOR 2
SELECT 
 productName
FROM products
EXCEPT
SELECT
	productName
FROM products
JOIN
orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE c.customerNumber IN
(SELECT customerNumber
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
WHERE priceEach > (SELECT
AVG(priceEach) FROM orderdetails)
GROUP BY customerNumber
HAVING COUNT(DISTINCT orderNumber) > 10)


-- Nomor 3
SELECT
	customerName
FROM customers
JOIN payments
USING(customerNumber)
GROUP BY customerNumber
having sum(amount) > (SELECT 
AVG(total)*2 AS `rata-rata`
FROM 
(SELECT
SUM(amount) AS total
FROM payments
GROUP BY customerNumber) AS `.`)
INTERSECT
SELECT customerName
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
WHERE productLine IN ('Planes', 'Trains')
GROUP BY productName
HAVING SUM(quantityOrdered * priceEach) > 20000

SELECT 
AVG(total) AS `rata-rata`
FROM 
(SELECT
SUM(amount) AS total
FROM payments
GROUP BY customerNumber) AS `.`



-- NOMOR 4
SELECT Tanggal,
   customerNumber,
   GROUP_CONCAT(DISTINCT riwayat ORDER BY customerNumber SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT orderDate AS Tanggal,
      customerNumber,
      'Memesan Barang' AS riwayat
    FROM orders
    WHERE orderDate LIKE '2003-09-__'
    UNION 
    SELECT paymentDate AS Tanggal,
      customerNumber,
      'Membayar Pesanan' AS riwayat
    FROM payments
    WHERE paymentDate LIKE '2003-09-__'
) AS gabungan
GROUP BY Tanggal
ORDER BY Tanggal

-- NOMOR 5
SELECT
	productCode
FROM products
JOIN orderdetails
USING(productCode)
WHERE priceEach > (SELECT
AVG(priceEach) FROM orderdetails
JOIN orders
USING(orderNumber)
WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31')
AND quantityordered > 48 
AND LEFT(productVendor,1) IN ('a','i','u','e','o')
EXCEPT
SELECT DISTINCT 
	productCode
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
JOIN customers
USING(customerNumber)
WHERE country IN ('Japan','Italy','Germany') 
	
	





















