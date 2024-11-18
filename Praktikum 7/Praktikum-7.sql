-- NOMOR 1
SELECT
	productCode,
	productName,
	buyPrice
FROM products
WHERE buyprice > (SELECT
	AVG(buyprice)
	FROM products)
	
-- NOMOR 2
SELECT
	o.orderNumber,
	o.orderDate
FROM orders o
JOIN customers c
ON o.customerNumber = c.customerNumber
WHERE c.salesRepEmployeeNumber IN
(SELECT e.employeeNumber
FROM employees e
JOIN offices
ON e.officeCode = offices.officeCode
WHERE offices.city = 'Tokyo')

-- NOMOR 3
SELECT
   c.customerName,
   o.orderNumber,
   o.shippedDate,
   o.requiredDate,
   (SELECT 
   GROUP_CONCAT(p.productName) 
   FROM orderdetails od
   JOIN products p 
   USING(productCode)
   WHERE od.orderNumber = o.orderNumber
	) AS `products`,
   (SELECT 
   SUM(od.quantityOrdered) 
   FROM orderdetails od
   WHERE od.orderNumber = o.orderNumber) AS total_quantity_ordered,
	CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.shippedDate > o.requiredDate

-- NOMOR 4
SELECT
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
WHERE p.productLine IN (
    SELECT productLine
    FROM (
        SELECT p.productLine, SUM(od.quantityOrdered) AS total_quantity
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        GROUP BY p.productLine
        ORDER BY total_quantity DESC
        LIMIT 3
    ) AS top_3
)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC

SELECT
SUM(quantityordered*priceEach) AS `Total harga semua pesanan`,
YEAR(orderdate) AS tahun
FROM orderdetails
JOIN orders
USING(orderNumber)
WHERE YEAR(orderdate) = (SELECT YEAR(orderdate)
FROM orders
JOIN orderdetails
USING(orderNumber)
GROUP BY YEAR(orderdate)
ORDER BY SUM(quantityordered*priceEach)
LIMIT 1)

group BY tahun












	
	
	

	



