#NAMA : An Naura Erwana Dwi Putri
#NIM : H071231051

#1
USE classicmodels

SELECT
	customerNumber,
	customerName,
	country
FROM customers
WHERE (country = 'USA' AND creditLimit > 50000 AND creditLimit < 100000)
	OR (country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;


#2
SELECT 
	productCode,
	productName,
	quantityInStock,
	buyPrice 
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000)
	AND 
	(buyPrice < 50 OR buyPrice > 150)
	AND 
	(productLine NOT LIKE '%vintage%');
	
#3
SELECT 
	productCode,
	productName,
	MSRP
FROM products
WHERE productLine LIKE '%classic%' 
	AND 
	buyPrice > 50;

#4
SELECT 
	orderNumber,
	orderDate,
	`status`,
	customerNumber
FROM orders
WHERE orderNumber > 10250 
	AND 
	status NOT IN ('Shipped', 'Cancelled')
	AND 
	(orderDate BETWEEN '2004-01-01' AND '2005-12-31')
	
#5
SELECT
	orderNumber,
	orderLineNumber,
	productCode,
	quantityOrdered,
	priceEach,
	priceEach * quantityOrdered AS 'Total Price',
	(priceEach - (priceEach * 5 / 100)) * quantityOrdered AS 'discountedTotalPrice'
FROM orderdetails
WHERE quantityOrdered > 50 AND priceEach > 100 
	AND
		productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice
LIMIT 1;