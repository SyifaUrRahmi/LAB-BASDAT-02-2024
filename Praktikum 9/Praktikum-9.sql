-- NOMOR 1
CREATE DATABASE smbola

CREATE TABLE klub(
id INT AUTO_INCREMENT PRIMARY KEY, 
nama_klub VARCHAR(50) NOT NULL,
kota_asal VARCHAR(20) NOT NULL
)

CREATE TABLE pemain(
id INT AUTO_INCREMENT PRIMARY KEY,
nama_pemain VARCHAR(50) NOT NULL,
posisi VARCHAR(20) NOT NULL,
id_klub INT,
FOREIGN KEY (id_klub) REFERENCES klub(id)
)

CREATE TABLE pertandingan(
id INT AUTO_INCREMENT PRIMARY KEY,
id_klub_tuan_rumah INT,
foreign KEY (id_klub_tuan_rumah) REFERENCES klub(id),
id_klub_tamu INT, 
FOREIGN KEY (id_klub_tamu) REFERENCES klub(id),
tanggal_pertandingan DATE NOT NULL,
skor_tuan_rumah INT DEFAULT 0,
skor_tamu INT DEFAULT 0
)

ALTER TABLE pemain
ADD INDEX index_posisi(posisi)

ALTER TABLE klub
ADD INDEX index_kota_asal(kota_asal)

-- NOMOR 2
SELECT
customerName,
country,
SUM(amount) AS totalPayment,
COUNT(orderNumber) AS orderCount,
MAX(paymentDate) AS LastPaymentDate,
case
when SUM(amount) > 100000 then 'VIP'
when SUM(amount) BETWEEN 5000 AND 100000 then 'Loyal'
ELSE 'New'
END AS `Status`
FROM
customers
LEFT JOIN payments
USING(customerNumber)
LEFT JOIN orders
USING(customerNumber)
GROUP BY customerName

-- NOMOR 3
SELECT
customerNumber,
customerName,
SUM(quantityOrdered) AS total_quantity,
CASE
WHEN SUM(quantityOrdered) > (
SELECT AVG(total_quantity) 
FROM (
SELECT customerNumber, SUM(quantityOrdered) AS total_quantity
FROM orders
JOIN orderdetails USING (orderNumber)
GROUP BY customerNumber
) AS jumlahorder
) THEN 'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS kategori_pembelian
FROM customers 
JOIN orders USING (customerNumber)
JOIN orderdetails  USING (orderNumber)
GROUP BY customerName
ORDER BY total_quantity DESC



