-- nomor 1
SELECT 
	productCode, 
	productName, 
	buyPrice
FROM products 
WHERE buyPrice > (
	SELECT AVG(buyPrice) 
	FROM products
)
-- ORDER BY p.buyPrice DESC;

-- nomor 2
SELECT 
	o.orderNumber, 
	o.orderDate
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.employeeNumber IN (
	SELECT employeeNumber FROM employees
	JOIN offices 
	USING(officeCode)
	WHERE city = 'Tokyo'
);

-- nomor 3

SELECT 
	c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, 
	GROUP_CONCAT(p.productName) `products`, 
	sum(od.quantityOrdered) total_quantity_ordered , 
	concat(e.firstName, " ", e.lastName) employeeName 
from customers c
join orders o
using(customerNumber)
join orderdetails od
using (orderNumber)
join products p
using(productCode)
join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.productCode IN (
	select productCode FROM products
		where shippedDate 
		> requiredDate
)
GROUP BY orderNumber

-- nomor 4
SELECT 
	p.productName, 
	p.productLine, 
	SUM(od.quantityOrdered) total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE productline IN
		(SELECT productLine  FROM ( 
			 SELECT productline 
		    FROM products
		    JOIN orderdetails  
			 USING(productCode)
		    GROUP BY productLine
		    ORDER BY SUM(quantityOrdered) DESC
		    LIMIT 3) top3 
		)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;



-- soal tambahan
SELECT e.employeeNumber, e.jobTitle
FROM employees e
WHERE e.employeeNumber NOT IN (
	SELECT salesRepEmployeeNumber FROM customers
 WHERE salesRepEmployeeNumber IS NOT NULL 
);