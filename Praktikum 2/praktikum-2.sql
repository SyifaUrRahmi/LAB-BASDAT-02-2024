USE classicmodels;
-- nomor 1
SELECT * FROM products;
SELECT productcode AS 'Kode Produk' ,
productName AS 'Nama Produk',
quantityInStock AS 'Jumlah Stok' 
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000;
-- WHERE quantityInStock >= 5000 AND quantityInStock <=6000;

-- nomor 2
SELECT * FROM orders;
SELECT orderNumber AS 'Nomor Pesanan',
orderDate AS 'Tanggal Pesanan',
STATUS,
customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS <> "shipped"
ORDER BY customerNumber;

-- nomor 3
SELECT * FROM employees;
SELECT employeeNumber AS 'Nomor Karyawan',
firstName, lastName, email,
jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName
LIMIT 10;

-- nomor 4
SELECT * FROM products;
SELECT productCode AS 'Kode Produk',
productName AS 'Nama Produk',
productLine AS 'Lini Produk',
buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyPrice DESC
LIMIT 5,10;

-- nomor 5
SELECT * FROM customers;
SELECT DISTINCT country, city
FROM customers
ORDER BY country, city;

-- soal tambahan
SELECT productName AS 'nama produk',
quantityInStock AS 'stok'
FROM products
WHERE quantityInStock <50
ORDER BY quantityInStock ASC 