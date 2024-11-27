-- tp8
-- nomor 1

(SELECT 
	productName,
	SUM(PriceEach * quantityOrdered) AS TotalRevenue,
	"Pendapatan Tinggi" Pendapatan
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue DESC 
LIMIT 5
)

UNION 
(SELECT 
	productName,
	SUM(PriceEach * quantityOrdered) AS TotalRevenue,
	"Pendapatan Pendek (kayak kamu)" Pendapatan
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue ASC 
LIMIT 5
)
ORDER BY TotalRevenue DESC 

-- nomor 2
SELECT productname 
FROM products

EXCEPT 
    SELECT productName 
     FROM products
     JOIN orderdetails USING(productCode)
     JOIN orders USING(orderNumber)
     JOIN customers USING(customerNumber)
     WHERE customerNumber IN 
         (SELECT customerNumber
          FROM customers
          JOIN orders USING(customerNumber)
          JOIN orderdetails USING(orderNumber)
          JOIN products USING(productCode)
          WHERE PriceEach > 
              (SELECT AVG(PriceEach) 
               FROM orderDetails)
         INTERSECT 
         SELECT customerNumber
         FROM customers
         JOIN orders USING(customerNumber)
         GROUP BY customerNumber
         HAVING COUNT(orderNumber) > 10
         )
    
    
-- nomor 3
SELECT customername
FROM customers
JOIN payments
USING(customerNumber)
GROUP BY customername
HAVING SUM(amount) > 
(SELECT 2*AVG(total)
	FROM 
		(SELECT SUM(amount) total
		FROM payments 
		GROUP BY customerNumber ) a
		)

INTERSECT

SELECT customername
FROM customers
JOIN orders USING (customernumber)
JOIN orderdetails USING(ordernumber)
JOIN products USING(productcode)
WHERE 
	productline IN ('Planes', 'Trains')
GROUP BY
customername
HAVING SUM(priceEach*quantityOrdered) > 20000;

-- nomor 4
SELECT Tanggal, customerNumber, 
GROUP_CONCAT(riwayat SEPARATOR ' dan ') riwayat
FROM 
(SELECT orderDate AS Tanggal, 
customerNumber, 
'Memesan Barang' AS riwayat
FROM orders
WHERE MONTH(orderDate) = 9 AND YEAR(orderDate) = 2003

UNION 

SELECT paymentDate AS Tanggal, 
customerNumber, 
'Membayar Pesanan' AS riwayat
FROM payments
WHERE MONTH(paymentDate) = 9 AND YEAR(paymentDate) = 2003
) AS a
GROUP BY Tanggal 


-- nomor 5
SELECT productCode
FROM products 
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE priceEach > (
        SELECT AVG(priceEach)
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        JOIN orders o ON od.orderNumber = o.orderNumber
        WHERE o.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
    )
  AND quantityOrdered > 48
  AND LEFT(productVendor, 1) IN ('A','I','U','E', 'O')
  
EXCEPT 

SELECT productCode
FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE country IN ('Japan', 'Germany', 'Italy')
ORDER BY productCode

