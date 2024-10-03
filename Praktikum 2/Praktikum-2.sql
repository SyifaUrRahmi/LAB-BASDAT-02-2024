USE classicmodels

-- nomor 1
SELECT productcode AS "Kode Produk", productname AS "Nama Produk", quantityInstock AS "Jumlah Stok" FROM products
WHERE quantityInstock BETWEEN 5000 AND 6000

-- nomor 2
SELECT ordernumber AS "Nomor Pesanan", orderdate AS "Tanggal Pesanan", `status`, customernumber AS "Nomor Pelanggan" FROM orders
WHERE status <> "shipped" ORDER BY ordernumber

-- nomor 3
SELECT employeenumber AS "Nomor Karyawan", firstname, lastname, email, jobtitle AS "Jabatan" FROM employees
WHERE jobtitle = "Sales Rep" ORDER BY firstname LIMIT 10

-- nomor 4
SELECT productcode AS "Kode Produk", productname AS "Nama Produk", productline AS "Lini Produk", buyprice AS "Harga Beli" FROM products
ORDER BY buyprice DESC LIMIT 5,10 

-- nomor 5
SELECT DISTINCT country,city FROM customers ORDER BY country

SELECT productname, quantityinstock FROM products WHERE quantityinstock > 1000 ORDER BY quantityinstock 

SELECT productname, buyprice FROM products WHERE buyprice BETWEEN 50 AND 100 ORDER BY buyprice
