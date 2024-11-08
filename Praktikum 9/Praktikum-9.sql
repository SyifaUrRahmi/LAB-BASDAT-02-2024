#Nama: An Naura Erwana Dwi Putri
#NIM: H071231051

#1
CREATE DATABASE sepakbola;

USE sepakbola;

CREATE TABLE klub(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY (id_klub) REFERENCES klub(id) 
);

CREATE TABLE pertandingan(
	id INT AUTO_INCREMENT  PRIMARY KEY,
	id_klub_tuan_rumah INT,
	FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub(id),
	id_klub_tamu INT,
	FOREIGN KEY (id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

ALTER TABLE pemain
ADD INDEX index_posisi(posisi);

ALTER TABLE klub
ADD INDEX index_kota(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;

#2 
USE classicmodels;

SELECT 
	c.customerName,
	c.country,
	FORMAT(SUM(p.amount), 2) AS 'totalAmount',
	COUNT(o.orderNumber) AS 'CountOrder',
	MAX(p.paymentDate) AS 'LastPayments',
	case
	when SUM(p.amount) > 100000 then 'VIP'
	when SUM(p.amount) BETWEEN 5000 AND 100000 then 'Loyal'
	ELSE 'New'
	END AS 'Status'
FROM customers c
LEFT JOIN payments p 
USING(customerNumber)
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
ORDER BY c.customerName


#3
SELECT 
	c.customerNumber,
	c.customerName,
	SUM(od.quantityOrdered) AS 'total_quantity',
	case 
	when SUM(od.quantityOrdered) > ( 
		SELECT AVG(total)
		FROM (
			SELECT SUM(quantityOrdered) AS total
			FROM orderdetails
			JOIN orders
			USING(orderNumber)
			GROUP BY customerNumber
		) AS totalquantity) then 'di atas rata-rata'
	ELSE 'di bawah rata-rata'
	END AS 'kategori_pembelian'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
GROUP BY c.customerNumber
ORDER BY `total_quantity` DESC 


#soal tambahan

USE library;

INSERT INTO authors (`name`, nationality)
VALUES 
	( 'Gabriel Garcia Marquez', 'Colombian'),
	('Haruki Murakami', ''),
	('George Orwell', 'British'),
	('J.K. Rowling', 'British')
	
SELECT * FROM authors
ROLLBACK 
COMMIT 

	
INSERT INTO books (isbn,title, author_id, published_year, genre, copies_available)
VALUES 
	('7040289780000', 'Norwegian Wood', 6, 1987, 'Romance', 12),
	('9780375704000', '1984', 7, 1949, 'Dystopian', 3),
	('978074753200', "Harry Potter and the Philosopher's Stone", 8, 1997, '', 2),
	('7210301703000', 'The Running Grave', 8, 2016, 'Fiction', 20);

SELECT * FROM books
JOIN authors
on authors.id =  books.author_id

COMMIT 

INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES 
	('Ethan', 'Collins', 'ethan@example.com', NULL, '2024-03-24', ''),
	('Sofia', 'Rivera', 'rivera@example.com', 0001231231, '2024-04-05', 'Standar'),
	('Williams', '', 'williams123@example.com', 3213214456, '2023-04-06', 'Premium');
	
SELECT * FROM members

COMMIT 
	
	
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (1, 13, '2024-07-10', '2024-07-25'),
	(1, 16, '2024-08-01', NULL ),
	(3, 15, '2024-09-06', '2024-09-09'),
	(2, 13, '2024-09-08', NULL ),
	(3, 14, '2024-09-10', NULL );
	
SELECT 
	CONCAT(m.first_name, " ", m.last_name) AS namaMember,
	bk.title AS judulBuku,
	b.borrow_date,
	b.return_date
FROM borrowings b
JOIN members m
ON b.member_id = m.id
JOIN books bk
ON b.book_id = bk.id
	
ROLLBACK 
COMMIT 

SET autocommit = OFF;

START TRANSACTION 

SELECT * FROM members;
SELECT * FROM books;
SELECT * FROM borrowings;
SELECT * FROM authors;


	