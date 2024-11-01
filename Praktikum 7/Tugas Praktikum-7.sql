# Nama : An Naura Erwana Dwi Putri
# NIM : H071231051

#1
SELECT 
	p1.productCode,
	p1.productName,
	p1.buyprice
FROM products p1
WHERE p1.buyPrice > ( 
	SELECT AVG(p2.buyPrice)
	FROM products p2
)

#2
SELECT 
	o.orderNumber,
	o.orderDate
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN employees e1
ON c.salesRepEmployeeNumber = e1.employeeNumber
WHERE e1.employeeNumber IN ( 
	SELECT employeeNumber
	FROM employees e2
	JOIN offices `of`
	USING(officeCode)
	WHERE `of`.city = 'Tokyo'
)

#3
SELECT 
   c.customerName,
   o.orderNumber,
   o.shippedDate,
   o.requiredDate,
   GROUP_CONCAT(p.productName) AS 'products',
   SUM(od.quantityOrdered) AS 'total_quantity_ordered',
   CONCAT(e.firstName, ' ', e.lastName) AS 'employeeName'
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN OrderDetails od
USING(orderNumber)
JOIN products p 
USING(productCode)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber IN (
   	SELECT o1.orderNumber
      FROM orders o1
      WHERE o1.shippedDate > o1.requiredDate
)
GROUP BY o.orderNumber
    
#4
SELECT
   p.productName,
   p.productLine,
   SUM(od.quantityOrdered) AS 'total_quantity_ordered'
FROM products p
JOIN orderdetails od
USING (productCode)
WHERE p.productLine IN (
   SELECT productLine
   FROM (
      SELECT p1.productLine
      FROM products p1
      JOIN orderdetails od1
      USING (productCode)
      GROUP BY p1.productLine
      ORDER BY SUM(od1.quantityOrdered) DESC
      LIMIT 3
   ) AS top_product_lines
)
GROUP BY p.productCode
ORDER BY p.productLine, total_quantity_ordered DESC;


SELECT COUNT(e.employeenumber) AS 'jumlah_karyawan'
FROM employees e
WHERE e.employeeNumber NOT IN (
	SELECT salesRepEmployeeNumber FROM customers
	WHERE salesRepEmployeeNumber IS NOT NULL 
)
	
