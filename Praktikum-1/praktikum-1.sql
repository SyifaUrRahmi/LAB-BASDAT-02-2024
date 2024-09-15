CREATE DATABASE library;
USE library;
-- nomor 1
CREATE TABLE author (
	id INT PRIMARY KEY,
	nama VARCHAR(100) NOT NULL
);
DESCRIBE author
CREATE TABLE books (
	id INTEGER PRIMARY KEY,
	isbn CHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INTEGER,
	FOREIGN KEY(author_id) REFERENCES author(id)
);

ALTER TABLE author
MODIFY id INTEGER AUTO_INCREMENT;

ALTER TABLE books
MODIFY id INTEGER AUTO_INCREMENT;

-- nomor 2
ALTER TABLE author
ADD nationality VARCHAR(50)

-- nomor 3
ALTER TABLE books
MODIFY isbn CHAR(13) UNIQUE

-- nomor 4
DESCRIBE books
DESCRIBE author

CREATE TABLE members(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	member_id INTEGER NOT NULL,
	FOREIGN KEY (member_id) REFERENCES members(id),
	book_id INTEGER NOT NULL,
	FOREIGN KEY (book_id) REFERENCES books(id),
	borrow_date DATE NOT NULL,
	return_date DATE
);

ALTER TABLE books
ADD published_year INTEGER NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INTEGER NOT NULL;

ALTER TABLE books
MODIFY title VARCHAR(150) NOT NULL,
MODIFY isbn CHAR(13) NOT NULL,
MODIFY author_id INT(11) NOT NULL;

ALTER TABLE author
MODIFY nationality VARCHAR(50) NOT NULL;

DESCRIBE books;
DESCRIBE borrowings;
DESCRIBE authors;
DESCRIBE members;

ALTER TABLE books MODIFY copies_available INT;

ALTER TABLE author RENAME TO authors;

SHOW TABLES;