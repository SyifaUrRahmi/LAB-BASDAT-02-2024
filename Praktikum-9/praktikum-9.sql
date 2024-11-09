CREATE DATABASE praktikum9;

USE praktikum9; 

CREATE TABLE klub (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nama_klub VARCHAR(50) NOT NULL,
    kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nama_pemain VARCHAR(50) NOT NULL,
    posisi VARCHAR(20) NOT NULL,
    id_klub INTEGER,
    FOREIGN KEY (id_klub) REFERENCES klub (id)
);

CREATE TABLE pertandingan (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_klub_tuan_rumah INTEGER,
    id_klub_tamu INTEGER,
    tanggal_pertandingan DATE NOT NULL,
    skor_tuan_rumah INTEGER DEFAULT 0,
    skor_tamu INTEGER DEFAULT 0,
    FOREIGN KEY (id_klub_tuan_rumah) REFERENCES klub (id),
    FOREIGN KEY (id_klub_tamu) REFERENCES klub (id)
);

CREATE INDEX idx_posisi ON pemain (posisi);

DESCRIBE pemain;

DESCRIBE pertandingan;

DESCRIBE klub;

CREATE INDEX idx_kota_asal ON klub (kota_asal);

DESCRIBE klub;

--nomor 2
USE classicmodels;

SELECT
    customerName,
    country,
    SUM(amount) as TotalPayment,
    COUNT(orderNumber) as orderCount,
    MAX(paymentDate) as LastPaymentDate,
    CASE
        WHEN SUM(amount) < 5000
        or amount is null THEN "New"
        WHEN SUM(amount) BETWEEN 5000 AND 100000  THEN "Loyal"
        ELSE "VIP"
    END AS Status
FROM customers
    LEFT JOIN payments USING (customerNumber)
    LEFT JOIN orders USING (customerNumber)
GROUP BY
    customerNumber
ORDER BY customerName;

--nomor 3
SELECT
    customerNumber,
    customerName,
    SUM(quantityOrdered) as total_quantity,
    CASE
        WHEN SUM(quantityOrdered) > (
            (
                SELECT AVG(total_quantity)
                FROM (
                        SELECT SUM(quantityOrdered) as total_quantity
                        FROM
                            orderdetails
                            JOIN orders USING (orderNumber)
                            JOIN customers USING (customerNumber)
                        GROUP BY
                            customerNumber
                    ) as total_quantity
            )
        ) THEN "di atas rata-rata"
        ELSE "di bawah rata-rata"
    END
FROM
    customers
    JOIN orders USING (customerNumber)
    JOIN orderdetails USING (orderNumber)
GROUP BY
    customerNumber
ORDER BY total_quantity DESC;

USE library;

SET autocommit = 0;

INSERT INTO
    authors (nama, nationality)
VALUES (
        "Gabriel Garcia Marquez",
        "Colombian"
    ),
    ("Haruki Murakami", DEFAULT),
    ("George Orwell", "British"),
    ("J.K. Rowling", "British");

SELECT * from authors;

commit;

INSERT INTO
    books (
        isbn,
        title,
        author_id,
        published_year,
        genre,
        copies_available
    )
VALUES (
        "7040289780000",
        "Norwegian Wood",
        (
            SELECT id
            FROM authors
            WHERE
                nama = 'Haruki Murakami'
        ),
        1987,
        "Romance",
        12
    ),
    (
        "9780375704000",
        "1984",
        (
            SELECT id
            FROM authors
            WHERE
                nama = 'George Orwell'
        ),
        1949,
        "Dystopian",
        3
    ),
    (
        "978074753200",
        "Harry Potter and the Philosopher's Stone",
        (
            SELECT id
            FROM authors
            WHERE
                nama = 'J.K. Rowling'
            GROUP BY
                nama
        ),
        1997,
        DEFAULT,
        2
    ),
    (
        "7210301703000",
        "The Running Grave",
        (
            SELECT id
            FROM authors
            WHERE
                nama = 'J.K. Rowling'
            GROUP BY
                nama
        ),
        2016,
        "Fiction",
        20
    );

SELECT *, (
        select nama
        from authors
        where
            id = author_id
    ) as namaAuthor
from books;

commit;

INSERT INTO
    members (
        first_name,
        last_name,
        email,
        phone_number,
        join_date,
        membership_type
    )
VALUES (
        "Ethan",
        "Collins",
        "ethan@example.com",
        NULL,
        "2024-03-24",
        DEFAULT
    ),
    (
        "Sofia",
        "Rivera",
        "rivera@example.com",
        "0001231231",
        "2024-04-05",
        "Standar"
    ),
    (
        "Williams",
        DEFAULT,
        "williams123@example.com",
        "3213214456",
        "2023-04-06",
        "Premium"
    );

select * from members;

commit;

INSERT INTO
    borrowings (
        member_id,
        book_id,
        borrow_date,
        return_date
    )
VALUES (
        (
            SELECT id
            FROM members
            WHERE
                concat(first_name, " ", last_name) = "Ethan Collins"
        ),
        (
            SELECT id
            FROM books
            WHERE
                title = "Norwegian Wood"
        ),
        "2024-07-10",
        "2024-07-25"
    ),
    (
        (
            SELECT id
            FROM members
            WHERE
                concat(first_name, " ", last_name) = "Ethan Collins"
        ),
        (
            SELECT id
            FROM books
            WHERE
                title = "The Running Grave"
            group by
                title
        ),
        "2024-08-01",
        NULL
    ),
    (
        (
            SELECT id
            FROM members
            WHERE
                first_name = "Williams"
        ),
        (
            SELECT id
            FROM books
            WHERE
                title = "Harry Potter and the Philosopher's Stone"
            group by
                title
        ),
        "2024-09-06",
        "2024-09-09"
    ),
    (
        (
            SELECT id
            FROM members
            WHERE
                concat(first_name, " ", last_name) = "Sofia Rivera"
        ),
        (
            SELECT id
            FROM books
            WHERE
                title = "Norwegian Wood"
        ),
        "2024-09-08",
        NULL
    ),
    (
        (
            SELECT id
            FROM members
            WHERE
                first_name = "Williams"
        ),
        (
            SELECT id
            FROM books
            WHERE
                title = "1984"
        ),
        "2024-09-10",
        NULL
    );

rollback;

select *, (
        select first_name
        from members
        where
            id = member_id
    ) as namaMember, (
        select title
        from books
        where
            id = book_id
    ) as namaBuku
from borrowings;

commit;

START TRANSACTION;