#Nama: An Naura Erwana Dwi Putri
#NIM: H071231051


#1
(
	SELECT 
		p.productName,
		SUM(od.priceEach * od.quantityordered) AS 'TotalRevenue',
		'Pendapatan Tinggi' AS pendapatan
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	WHERE MONTH(orderDate) = 9
	GROUP BY p.productName
	ORDER by TotalRevenue desc
	LIMIT 5
)
UNION
(
	SELECT 
		p.productName,
		SUM(od.priceEach * od.quantityordered) AS 'TotalRevenue',
		'Pendapatan Rendah' AS pendapatan
	FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	WHERE MONTH(orderDate) = 9
	GROUP BY p.productName
	ORDER by TotalRevenue
	LIMIT 5
)
ORDER BY TotalRevenue DESC 

#2
SELECT p.productName
FROM products p
EXCEPT
SELECT p.productName
FROM products p
JOIN orderdetails od 
USING(productCode)
JOIN orders o 
USING(orderNumber)
WHERE customerNumber IN (
   SELECT customerNumber
   FROM orders
   GROUP BY customerNumber
   HAVING COUNT(*) > 10
   INTERSECT
   SELECT DISTINCT o.customerNumber
   FROM orders o
   JOIN orderdetails od 
	USING(orderNumber) 
   WHERE od.priceEach > (
      SELECT AVG(priceEach)
      FROM orderdetails
    )
)

#3
SELECT customerName
FROM customers
JOIN payments
USING(customerNumber)
GROUP BY customerNumber
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAmount)
    FROM (
        SELECT DISTINCT SUM(amount) AS totalAmount
        FROM payments
        GROUP BY customerNumber
    ) AS hasil
)
INTERSECT
SELECT c.customerName
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od 
USING(orderNumber)
JOIN products AS p 
USING(productCode)
WHERE p.productLine IN ('Planes', 'Trains')
GROUP BY c.customerNumber
HAVING SUM(priceEach * quantityOrdered) > 20000;

#4
SELECT DISTINCT 
	o.orderdate AS 'Tanggal',
	c.customerNumber,
	'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN payments p
ON o.orderDate = p.paymentDate
WHERE orderDate LIKE '2003-09%'
UNION 
SELECT 
	orderdate AS 'Tanggal',
	customerNumber,
	'Memesan Barang' AS 'riwayat'
FROM orders
WHERE orderDate LIKE '2003-09%' 
	AND orderDate NOT IN (
		SELECT paymentDate FROM payments
	)
UNION 
SELECT 
	paymentdate AS 'Tanggal',
	customerNumber,
	'Membayar Barang' AS 'riwayat'
FROM payments
WHERE paymentDate LIKE '2003-09%' 
	AND paymentdate NOT IN (
		SELECT orderdate FROM orders
	)
ORDER BY `Tanggal`

#5
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
WHERE priceEach > (
   SELECT AVG(priceEach) FROM orderdetails 
   JOIN orders 
	USING(orderNumber)
   WHERE orderDate BETWEEN '2001-01-01' and '2004-03-31'
)
	AND quantityOrdered > 48
	AND LEFT(productVendor, 1) IN ('A', 'I', 'U','E','O')
EXCEPT
SELECT DISTINCT productCode FROM products
JOIN orderdetails 
USING(productCode)
JOIN orders 
USING(orderNumber)
JOIN customers 
USING(customerNumber)
WHERE country in ("Japan", "Germany", "Italy");

