# Nama: An Naura Erwana Dwi Putri
# Nim: H071231051

USE classicmodels

#1
SELECT 
	productcode AS 'Kode Produk',
	productname AS 'Nama Produk',
	quantityInStock AS 'Jumlah Stok'
FROM products;
WHERE quantityInStock >= 5000 AND quantityInStock <= 6000 

#2
SELECT 
	orderNumber AS 'Nomor Pesanan',
	orderDate AS 'Tanggal Pesanan',
	status	AS 'status',
	customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != 'Shipped'
ORDER BY customerNumber;  


#3
SELECT 
	employeeNumber AS 'Nomor Karyawan',
	firstName,
	lastName,
	email,
	jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName
LIMIT 10;

#4
SELECT 
	productCode AS 'Kode Produk',
	productName AS 'Nama Produk',
	productLine AS 'Lini Produk',
	buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyPrice DESC
LIMIT 10 OFFSET 5;

#5
SELECT DISTINCT country, city 
FROM customers
ORDER BY country, city;
