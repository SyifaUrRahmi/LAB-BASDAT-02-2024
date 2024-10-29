-- nomor 1
SELECT customernumber,customername,country, creditlimit FROM customers
WHERE country = 'USA' AND creditlimit > 50000 AND creditlimit <100000
OR
country <> 'USA' AND creditlimit BETWEEN 100000 AND 200000
ORDER BY creditlimit DESC 

-- nomor 2
SELECT productcode,productname,quantityinstock,buyprice FROM products
WHERE quantityinstock BETWEEN 1000 AND 2000
AND 
buyprice < 50 OR buyprice > 150
AND productline  not LIKE '%Vintage%'

-- nomor 3
SELECT productcode, productname, MSRP FROM products
WHERE productline LIKE'%Classic%'AND buyprice > 50

-- nomor 4
SELECT ordernumber,orderdate,`status`,customernumber FROM orders
WHERE ordernumber > 10250 AND `status` NOT IN('Shipped','Cancelled')
AND orderdate BETWEEN '2004-01-01' AND '2005-12-31'

-- nomor 5
SELECT *, (priceeach*quantityordered*0.95) discountedTotalPrice FROM orderdetails
WHERE quantityordered > 50 AND priceeach > 100
AND productcode NOT LIKE 'S18%'
ORDER BY priceeach DESC 


