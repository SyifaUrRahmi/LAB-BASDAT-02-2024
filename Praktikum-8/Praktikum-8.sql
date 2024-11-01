(
	SELECT 
		p.productName, 
		SUM(od.priceEach * od.quantityOrdered) AS `TotalRevenue`, 
		'Pendapatan Tinggi' AS `Pendapatan`
	FROM products p
	JOIN orderdetails od 
	USING (productCode)
	JOIN orders o
	USING (orderNumber)
	WHERE MONTH(o.orderdate) = 9
	GROUP BY productName
	ORDER BY `TotalRevenue` DESC
	LIMIT 5
)

UNION 

(
	SELECT 
		p.productName, 
		SUM(od.priceEach * od.quantityOrdered) AS `TotalRevenue`, 
		'Pendapatan Pendek (kayak kamu)' AS `Pendapatan`
	FROM products p
	JOIN orderdetails od 
	USING (productCode)
	JOIN orders o
	USING (orderNumber)
	WHERE MONTH(o.orderdate) = 9
	GROUP BY productName
	ORDER BY `TotalRevenue`
	LIMIT 5
);



SELECT productName FROM products

EXCEPT

SELECT distinct p.productName
FROM customers c JOIN orders o USING(customerNumber)
JOIN orderdetails od USING(orderNumber)
JOIN products p USING(productCode)
WHERE o.customerNumber IN 
	(
	SELECT o.customerNumber 
	FROM orders o
	JOIN orderdetails od USING(orderNumber)
	WHERE od.priceEach > (SELECT AVG(priceEach) FROM orderdetails)
	GROUP BY o.customerNumber
	HAVING COUNT(distinct o.orderNumber) > 10
	);
	


SELECT customerName
FROM customers
JOIN payments USING (customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
	SELECT AVG(total_payments)
	FROM (
		SELECT SUM(amount) AS total_payments FROM payments
		GROUP BY customerNumber
	) AS subquery
)

INTERSECT 

SELECT customerName
FROM customers JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE productLine IN ('Planes', 'Trains')
GROUP BY customerNumber
HAVING SUM(priceEach * quantityOrdered) > 20000;



SELECT `Tanggal`, customerNumber, GROUP_CONCAT(DISTINCT `riwayat` SEPARATOR ' dan ') AS `riwayat`
FROM (
	SELECT 
		orderDate AS `Tanggal`,
		customerNumber,
		'Memesan Barang' AS `riwayat`
	FROM orders
	WHERE MONTH(orderDate) =  9 AND YEAR(orderDate) = 2003

	UNION 

	SELECT 
		paymentDate AS `Tanggal`,
		customerNumber,
		'Membayar Pesanan' AS `riwayat`
	FROM payments
	WHERE MONTH(paymentDate) =  9 AND YEAR(paymentDate) = 2003
) AS subquery
GROUP BY `Tanggal`;



SELECT DISTINCT  productCode
FROM products
JOIN orderdetails USING (productCode)
WHERE 
	priceEach > (
		SELECT AVG(priceEach) 
		FROM orderdetails 
		JOIN orders USING (orderNumber)
		WHERE orderdate BETWEEN '2001-01-01' AND '2004-03-31') AND 
	quantityOrdered > 48 AND 
	LEFT(productVendor, 1) IN ('a', 'i', 'u', 'e', 'o')
	
EXCEPT

SELECT DISTINCT productCode
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
WHERE country IN ('Japan', 'Italy', 'Germany')

ORDER BY productCode;