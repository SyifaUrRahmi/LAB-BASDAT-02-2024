USE classicmodels;

SELECT customerNumber, customerName, country, creditlimit
FROM customers
WHERE 
	(country = 'USA' AND (creditLimit > 50000 AND creditLimit < 100000)) OR 
	(country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

SELECT productCode, productName, quantityInStock, buyPrice 
FROM products
WHERE
	(quantityInstock BETWEEN 1000 AND 2000) AND 
	(buyPrice < 50 OR buyPrice > 150) AND
	(productLine NOT LIKE '%Vintage%');
	
SELECT productCode, productName, MSRP, buyprice, productline
FROM products
WHERE 
	productLine LIKE '%CLASSIC%' AND
	buyPrice > 50;
	
SELECT orderNumber, orderDate, `status`, customerNumber
FROM orders
WHERE
	(orderNumber > 10250) AND
	(STATUS NOT IN ('Shipped', 'Cancelled')) AND
	(YEAR(orderdate) BETWEEN 2004 AND 2005);

SELECT
	orderNumber, 
	orderLineNumber, 
	productCode, 
	quantityOrdered, 
	priceEach, 
	(priceEach * quantityordered) * 0.95 AS `discountedTotalPrice`
FROM orderdetails
WHERE
	(quantityOrdered > 50 AND priceEach > 100) and
	(productCode NOT LIKE 'S18%')
ORDER BY discountedTotalPrice DESC;