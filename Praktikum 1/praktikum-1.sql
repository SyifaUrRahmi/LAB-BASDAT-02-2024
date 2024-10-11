-- nomor 1

-- CREATE DATABASE library
-- USE library
-- CREATE TABLE authors (
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- `name` VARCHAR (100) NOT null
-- )

-- CREATE TABLE books (
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- isbn VARCHAR (13),
-- title VARCHAR (100) NOT NULL,
-- author_id INT,
-- FOREIGN KEY (author_id) REFERENCES authors(id)
-- )

-- nomor 2
-- ALTER TABLE authors
-- ADD nationality VARCHAR (50)

-- nomor 3
-- ALTER TABLE books
-- MODIFY isbn VARCHAR (13) UNIQUE 

-- nomor 4
-- SHOW TABLES 
-- DESCRIBE authors
-- DESCRIBE books
-- DESCRIBE members
-- DESCRIBE borrowings

-- nomor 5
-- ALTER TABLE books 
-- ADD published_year YEAR NOT NULL,
-- ADD genre VARCHAR (50) NOT NULL,
-- ADD copies_avaliable INT NOT NULL,
-- MODIFY title VARCHAR (150) NOT NULL

-- ALTER TABLE authors
-- MODIFY nationality VARCHAR (50) NOT NULL

-- CREATE TABLE members (
-- id INT PRIMARY KEY AUTO_INCREMENT,
-- first_name VARCHAR (50) NOT NULL,
-- last_name VARCHAR (50) NOT NULL,
-- email VARCHAR (100) NOT NULL UNIQUE,
-- phone_number CHAR (10),
-- join_date DATE NOT NULL,
-- membership_type VARCHAR (50) NOT NULL
-- )
-- 

-- CREATE TABLE borrowings(
-- id INT PRIMARY KEY AUTO_INCREMENT ,
-- member_id INT NOT NULL,
-- book_id INT NOT NULL,
-- borrow_date DATE NOT NULL,
-- return_date DATE,
-- FOREIGN KEY (book_id) REFERENCES books (id),
-- FOREIGN KEY (member_id) REFERENCES members (id)
-- )