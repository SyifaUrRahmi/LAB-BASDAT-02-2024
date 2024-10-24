USE classicmodels;

-- nomor 1
SELECT * FROM customers;
SELECT customerNumber, customerName, country 
FROM customers
WHERE country = 'usa'AND creditlimit > 50000 AND creditlimit < 100000
OR country <> 'usa' AND creditlimit >= 100000 AND creditlimit <= 200000
ORDER BY creditlimit DESC;

-- nomor 2
SELECT * FROM products;
SELECT productCode, productName, quantityInStock, buyPrice
FROM products
WHERE quantityinstock >= 1000 AND quantityinstock <= 2000 
AND buyprice < 50 OR buyprice > 150
AND productline NOT LIKE '%vintage%';

-- nomor 3
SELECT * FROM products;
SELECT productCode, productName, MSRP FROM products
WHERE productline LIKE '%classic%'
AND buyprice > 50;

-- nomor 4
SELECT * FROM orders;

SELECT orderNumber, orderDate, `status`, customerNumber
FROM orders
WHERE ordernumber > 10250
AND status NOT IN  ('Shipped','Cancelled') 
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31';

-- nomor 5
SELECT * FROM orderdetails;
SELECT orderNumber, orderLineNumber, productCode, quantityOrdered, priceEach, 
(priceeach * quantityordered * 0.95) AS discountedTotalPrice 
FROM orderdetails
WHERE quantityordered > 50 AND priceEach > 100
AND productcode NOT LIKE 'S18%'
ORDER BY discountedTotalPrice DESC;

-- soal tambahan
SELECT quantityOrdered, priceEach, (priceeach * quantityordered) AS total
FROM orderdetails
ORDER BY total DESC
LIMIT 1  
