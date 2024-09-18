SELECT * from customers;

SELECT productCode AS `Kode Produk`, productName AS `Nama Produk`, quantityInStock AS `Jumlah Stok`
FROM products 
WHERE quantityInStock > 5000 AND quantityInStock < 6000; 

SELECT orderNumber AS `Nomor Pesanan`, orderDate AS `Tanggal Pesanan`, STATUS, customerNumber AS `Nomor Pelanggan`
FROM orders
WHERE STATUS != "Shipped"
ORDER BY customerNumber;

SELECT employeeNumber AS `Nomor Karyawan`, firstName, lastName, email, jobTitle AS `Jabatan`
FROM employees
WHERE jobTitle = "sales rep"
ORDER BY firstName
LIMIT 10;

SELECT productCode AS `Kode Produk`, productName AS `Nama Produk`, productLine AS `Lini Produk`, buyPrice AS `Harga Beli`
FROM products
ORDER BY buyPrice DESC
LIMIT 5,10;

SELECT DISTINCT country, city
FROM customers
ORDER BY country, city;