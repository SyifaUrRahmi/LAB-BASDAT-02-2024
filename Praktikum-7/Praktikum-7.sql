USE classicmodels;

SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > 
	(
	SELECT AVG(buyprice) FROM products
	)
	
SELECT
	orderNumber, orderDate
FROM orders
JOIN customers USING (customerNumber)
JOIN employees ON salesrepemployeenumber = employeeNumber
JOIN offices USING (officecode)
WHERE employeeNumber IN 
	(
	SELECT employeeNumber FROM employees
	JOIN offices USING (officeCode)
	WHERE city = 'Tokyo'
	);
	
SELECT 
	c.customerName, 
	o.orderNumber, 
	o.shippedDate, 
	o.requiredDate, 
	GROUP_CONCAT(p.productName ORDER BY p.productName SEPARATOR ', ') AS `products`,
	SUM(od.quantityOrdered) AS `total_quantity_ordered`,
	CONCAT(e.firstName, ' ' , e.lastName) AS `employeeName`
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
JOIN products p USING (productCode)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN 
	(
	SELECT orderNumber FROM orders WHERE shippedDate > requiredDate
	)
GROUP BY o.orderNumber;
	
SELECT
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS `total_quantity_ordered`
FROM products p
JOIN orderdetails od USING (productCode)
JOIN (
    SELECT p.productLine
    FROM products p
    JOIN orderdetails od USING (productCode)
    GROUP BY p.productLine
    ORDER BY SUM(od.quantityOrdered) DESC
    LIMIT 3
) AS top_productlines USING (productline)
GROUP BY p.productCode
ORDER BY p.productLine, `total_quantity_ordered` DESC;

SELECT customerName FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o USING (officecode)
WHERE o.country IN 
	(
	SELECT DISTINCT country FROM offices
	WHERE 
		LEFT(country, 1) IN ('a', 'u', 'e', 'o') AND
		RIGHT(country, 1) IN ('a', 'u', 'e', 'o')
	)

