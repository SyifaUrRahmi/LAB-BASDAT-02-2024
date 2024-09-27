# Nama: An Naura Erwana Dwi Putri
# Nim: H071231051 

USE library;

#1
INSERT INTO authors (name, nationality)
VALUES ("Tere Liye", "Indonesian"),
	("J.K. Rowling", "British"),
	("Andrea Hirata", "");
SELECT * FROM authors
SELECT * FROM books

INSERT INTO books (isbn, title, author_id, published_year, genre, copies_available)
VALUES ("7040289780375", "Ayah", 9, 2015, "Finction", 15),
	("9780375704025", "Bumi",7 , 2014, "Fantasy", 5),
	("8310371703024", "Bulan", 7, 2015, "Fantasy", 3),
	("9780747532699", "Harry Potter and the Philosoper's Stone",8, 1997, "", 10),
	("7210301703022", "The Running Grave", 8, 2016, "Finction", 11);
	
ALTER TABLE books
ADD authorname VARCHAR (100) NOT NULL

UPDATE books
SET authorname = (SELECT name FROM authors WHERE authors.id = books.author_id);

SELECT * FROM members
INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ("John", "Doe", "John.doe@example.com", NULL, "2023-04-29", ""),
	("Alice", "Johnson", "alice.johnson@example.com", "1231231231", "2023-05-01", "Standar"),
	("Bob", "Williams", "bob.williams@example.com", "3213214321", "2023-06-20", "Premium");
	
SELECT * FROM members;

SELECT * FROM borrowings

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES (4, 35, "2023-07-10", "2023-07-25"),
	(6, 32, "2023-08-01", NULL ),
	(5, 36, "2023-09-06", "2023-09-09" ),
	(5, 34, "2023-09-08", NULL ),
	(6, 33, "2023-09-10", NULL );
	
ALTER TABLE borrowings
ADD book_title VARCHAR (100) NOT NULL

UPDATE borrowings
SET book_title = (SELECT title FROM books WHERE books.id = borrowings.book_id);

SELECT * FROM borrowings;

#2
UPDATE books
SET copies_available = copies_available - 1
WHERE id = 1 OR 2 OR 3;

SELECT * FROM books;
				
#3
SHOW CREATE TABLE borrowings;
SELECT * FROM members;
UPDATE members
SET membership_type = "Standar"
WHERE id = 6;

ALTER TABLE borrowings 
DROP FOREIGN KEY borrowings_ibfk_1;

ALTER TABLE borrowings
ADD CONSTRAINT borrowings_ibfk_1 FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE;
				
DELETE FROM members 
WHERE id = 5 OR id =6;			
				
SELECT * FROM members;
SELECT * FROM borrowings;

DELETE FROM books;
DELETE FROM authors;

				