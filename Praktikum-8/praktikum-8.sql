(
    SELECT
        productName,
        SUM(priceEach * quantityOrdered) AS TotalRevenue,
        "Pendapatan Tertinggi" AS Pendapatan
    FROM
        products AS p
        JOIN orderdetails AS od USING (productCode)
        JOIN orders AS o USING (ordernumber)
    WHERE
        month(orderDate) = 9
    GROUP BY
        productCode
    ORDER BY TotalRevenue DESC
    LIMIT 5
)
UNION
(
    SELECT
        productName,
        SUM(priceEach * quantityOrdered) AS TotalRevenue,
        "Pendapatan Pendek (kayak kamu)" AS Pendapatan
    FROM
        products AS p
        JOIN orderdetails AS od USING (productCode)
        JOIN orders AS o USING (ordernumber)
    WHERE
        month(orderDate) = 9
    GROUP BY
        productCode
    ORDER BY TotalRevenue
    LIMIT 5
)
ORDER BY totalRevenue DESC;

SELECT productName
FROM products EXCEPT
SELECT productName
FROM
    products
    JOIN orderdetails USING (productCode)
    JOIN orders USING (orderNumber)
    JOIN customers USING (customerNumber)
WHERE
    customerNumber IN (
        SELECT customernumber
        FROM customers
            JOIN orders USING (customernumber)
        GROUP BY
            customerNumber
        HAVING
            count(orderNumber) > 10 INTERSECT
        SELECT customerNumber
        FROM
            customers
            JOIN orders USING (customernumber)
            JOIN orderdetails USING (ordernumber)
            JOIN products USING (productcode)
        WHERE
            priceEach > (
                SELECT AVG(priceEach)
                FROM orderdetails
            )
        GROUP BY
            customerNumber
    )

SELECT customerName
FROM customers
    JOIN payments USING (customerNumber)
GROUP BY
    customerNumber
HAVING
    SUM(amount) > (
        SELECT (2 * AVG(amount))
        FROM (
                SELECT sum(amount) AS amount
                FROM payments
                GROUP BY
                    customerNumber
            ) AS s
    ) INTERSECT
SELECT customername
FROM
    customers
    JOIN orders USING (customernumber)
    JOIN orderdetails USING (ordernumber)
    JOIN products USING (productcode)
    JOIN productlines using(productline)
WHERE
    -- productLine IN ('Planes', 'Trains')
    productline = 'Planes' or productline = 'Trains'
GROUP BY
    customerNumber
HAVING
    SUM(quantityOrdered * priceEach) > 20000

SELECT
    Tanggal,
    customerNumber,
    group_concat(
        DISTINCT Riwayat1 separator " dan "
    ) Riwayat
FROM (
        SELECT o.orderDate Tanggal, c.customerNumber, "Memesan Barang" Riwayat1
        FROM orders o
            JOIN customers c USING (customerNumber)
        WHERE
            o.orderDate like("2003-09-%")
        UNION
        SELECT p.paymentDate Tanggal, c.customerNumber, "Membayar Pesanan" Riwayat1
        FROM payments p
            JOIN customers c USING (customerNumber)
        WHERE
            p.paymentDate like("2003-09-%")
        ORDER BY customerNumber
    ) s
GROUP BY
    Tanggal;

SELECT productCode
FROM products
JOIN orderdetails USING (productCode)
WHERE
    priceEach > (
        SELECT AVG(priceEach)
        FROM
            products
            JOIN orderdetails USING (productCode)
            JOIN orders USING (orderNumber)
        WHERE
            orderDate BETWEEN '2001-01-01' AND '2004-04-31'
    ) INTERSECT
SELECT productCode
FROM products
    JOIN orderdetails USING (productCode)
WHERE
    quantityOrdered > 48
    AND LEFT(productVendor, 1) IN ('a', 'i', 'u', 'e', 'o') EXCEPT
SELECT productCode
FROM
    products
    JOIN orderdetails USING (productCode)
    JOIN orders USING (orderNumber)
    JOIN customers USING (customerNumber)
WHERE
    country IN ('japan', 'germany', 'italy')
