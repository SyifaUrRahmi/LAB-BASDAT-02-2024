USE classicmodels;

SELECT
    productCode,
    productName,
    buyPrice
FROM products
WHERE
    buyPrice > (
        SELECT AVG(buyPrice)
        FROM products
    );

SELECT orderNumber, orderDate
FROM orders
WHERE
    customerNumber IN (
        SELECT customerNumber
        FROM customers
        WHERE
            salesRepEmployeeNumber IN (
                SELECT employeeNumber
                FROM employees
                WHERE
                    officeCode = (
                        SELECT officeCode
                        FROM offices
                        WHERE
                            city = 'Tokyo'
                    )
            )
    );

SELECT
    c.customerName,
    o.orderNumber,
    o.shippedDate,
    o.requiredDate,
    group_concat(p.productName) products,
    sum(od.quantityOrdered) total_quantity_ordered,
    concat(e.firstName, " ", e.lastName) employeeName
FROM
    customers c
    JOIN orders o USING (customerNumber)
    JOIN orderdetails od USING (orderNumber)
    JOIN products p USING (productCode)
    JOIN employees e on c.salesRepEmployeeNumber = e.employeeNumber
WHERE
    o.orderNumber IN (
        SELECT orderNumber
        FROM orders
        WHERE
            shippedDate > requiredDate
    )
GROUP BY orderNumber;

SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM products p
    JOIN orderdetails od USING (productCode)
WHERE p.productLine IN (
        SELECT productLine
        FROM (
                SELECT
                    productLine, SUM(quantityOrdered) AS totalQuantityOrdered
                FROM products p
                    JOIN orderdetails od USING (productCode)
                GROUP BY
                    productLine
                ORDER BY totalQuantityOrdered DESC
                LIMIT 3
            ) AS topCategories
    )
GROUP BY
    p.productCode
ORDER BY p.productLine, totalQuantityOrdered DESC;

SELECT
    customerNumber,
    checkNumber,
    amount
FROM payments
HAVING
    amount > (
        select avg(amount)
        from payments
    );

SELECT customerName, jumlah_produk
FROM (
        SELECT c.customerName, COUNT(od.orderNumber) AS jumlah_produk
        FROM
            customers c
            JOIN orders o USING (customerNumber)
            JOIN orderdetails od USING (orderNumber)
        WHERE
            c.creditLimit > 130000
        GROUP BY
            c.customerName
    ) AS subquery
ORDER BY jumlah_produk;

SELECT c.customerName, COUNT(od.orderNumber) AS jumlah_produk
FROM
    customers c
    JOIN orders o USING (customerNumber)
    JOIN orderdetails od USING (orderNumber)
WHERE
    c.creditLimit > 130000
GROUP BY
    c.customerName