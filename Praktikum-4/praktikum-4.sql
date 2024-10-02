-- Nomor 1
SELECT customerNumber, customerName, country FROM customers
WHERE (country = 'USA' AND (creditLimit > 50000 AND creditlimit < 100000)) OR 
(country != 'USA' AND creditLimit BETWEEN 100000 AND 200000)
ORDER BY creditLimit DESC;

-- Nomor 2
SELECT productCode, productName, quantityInStock, buyprice
FROM products
WHERE (quantityInStock BETWEEN 1000 AND 2000) AND 
(buyprice < 50 OR buyprice > 150) AND 
productLine NOT LIKE '%vintage%';

-- Nomor 3
SELECT productCode, productName, MSRP FROM products
WHERE productline LIKE '%classic%' AND
buyprice > 50;

-- Nomor 4
SELECT orderNumber, orderDate, `status`, customerNumber FROM orders
WHERE orderNumber > 10250 AND STATUS NOT IN ('Shipped','Cancelled')
AND YEAR(orderdate) BETWEEN 2004 AND 2005;

-- Nomor 5
SELECT orderNumber, orderlinenumber,productcode, quantityOrdered, priceEach, 
(quantityOrdered * priceEach) AS totalPrice,
(quantityOrdered * priceEach * 0.95) AS discountedTotalPrice FROM orderdetails
WHERE quantityordered > 50 AND priceEach > 100
AND productCode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;