universitySELECT productCode AS 'Kode Produk', 
productName AS 'Nama Produk',
quantityInStock AS 'Jumlah Stok'
FROM products
WHERE quantityInStock BETWEEN 5000 AND 6000;

SELECT orderNumber AS 'Kode Pesanan', orderDate AS 'Tanggal Pesanan', STATUS, customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != 'shipped';

SELECT employeeNumber AS 'Nomor Karyawan',
firstName, lastName, email, jobTitle AS 'Jabatan' FROM employees
WHERE jobTitle = 'Sales Rep' 
ORDER BY firstName
LIMIT 10;

SELECT productCode AS 'Kode Produk', 
productName AS 'Nama Pro duk',  
productLine AS 'Lini Produk',
buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

SELECT DISTINCT country, city FROM customers
ORDER BY country, city;

SELECT customerName AS 'Nama Pelanggan', phone AS 'Nomor Telepon', addressLine1 AS 'Alamat Utama',
city AS 'Kota', creditLimit AS 'Limit Kredit' FROM customers
WHERE country = 'Germany' AND creditLimit != '0,0'
ORDER BY creditLimit DESC;
