-- Creating Database
CREATE DATABASE bookstore;

-- Using this database
USE bookstore;

-- Creating Tables 
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age int,
    DOB date
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    language_id INT,
    publisher_id INT,
    publication_year YEAR,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    zip_Code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10, 2)
);

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    history_status_name varchar(100),
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Creating roles
CREATE ROLE 'customers', 'developers', 'administrators';

-- Granting Priviledges
GRANT ALL ON bookstore.* TO 'developers';
GRANT SELECT, INSERT, DELETE ON bookstore.* TO 'administrators';
GRANT SELECT ON bookstore.*  TO 'customers';

-- Creating users
CREATE USER
'developer1'@'localhost' IDENTIFIED BY '@dev1user',
'developer2'@'localhost' IDENTIFIED BY '@dev2user',
'administrator1'@'localhost' IDENTIFIED BY '@admin1user',
'administrator2'@'localhost' IDENTIFIED BY '@admin2user',
'customer1'@'localhost' IDENTIFIED BY '@customer1user',
'customer2'@'localhost' IDENTIFIED BY '@customer2user';

-- Assigning Roles to users
GRANT 'developers' TO 'developer1'@'localhost', 'developer2'@'localhost';
GRANT 'administrators' TO 'administrator1'@'localhost', 'administrator2'@'localhost';
GRANT 'customers' TO 'customer1'@'localhost', 'customer2'@'localhost';

SET DEFAULT ROLE 'developers' TO 'developer1'@'localhost', 'developer2'@'localhost';
SET DEFAULT ROLE 'administrators' TO 'administrator1'@'localhost', 'administrator2'@'localhost';
SET DEFAULT ROLE 'customers' TO 'customer1'@'localhost', 'customer2'@'localhost';

-- Inserting Some Data
INSERT INTO book_language(language_name) VALUES('English'), ('Spanish'), ('French');
INSERT INTO publisher(full_name) VALUES('James Kimithi'), ('Alex Opiyo'), ('Martha Ouma');
INSERT INTO author(first_name,last_name,age,DOB) VALUES('Peter','Owino',25,'2000-04-08'), ('Chris','Choto',34,'1991-04-08'), ('Paul','Omae',30,'1995-07-02');
INSERT INTO book(title,language_id,publisher_id,publication_year,price,stock_quantity) VALUES ('Be the Change',1,1,1999, 300.00, 30), ('Gone forever',2,2,1999, 400.99, 40), ('Hidden Promises',3,3,1989, 500.00, 70);
INSERT INTO book_author(book_id,author_id) VALUES (1,1), (2,2), (3,3);
INSERT INTO customer(first_name,last_name,email,phone_number) VALUES('Mercy','Cheptoo','mercycheptoo@gmail.com',0711535768), ('Mary','Kabii','kabiimary9@gmail.com',0789456768), ('Allan','Aoko','allanaoko@gmail.com',0724567789);
INSERT INTO address_status(status_name) VALUES('Current'), ('Old'), ('Current');
INSERT INTO country(country_name) VALUES('Kenya'), ('Tanzania'), ('Nigeria');
INSERT INTO address(city, zip_Code, country_id) VALUES('Nairobi', 00100, 1), ('Arusha', 0200, 2), ('Lagos', 0400, 3);
INSERT INTO customer_address(customer_id, address_id, status_id) VALUES(1, 1, 1), (2,2,2), (3,3,3);
INSERT INTO shipping_method(method_name,cost) VALUES('standard',99.99), ('Express',199.99), ('Overnight',299.99);  
INSERT INTO order_status(status_name) VALUES('Pending'), ('Shipped'), ('Delivered');
INSERT INTO cust_order(customer_id,order_date,shipping_method_id,status_id) VALUES(1,'2024-04-15',1,1), (2,'2024-09-10',2,2), (3,'2025-03-29',3,3);
INSERT INTO order_line(order_id,book_id,quantity,price) VALUES(1,1,20, 120.99), (2,2,50, 199.99), (3,3,25, 59.99);
INSERT INTO order_history(order_id,history_status_name,status_id,change_date) VALUES(1,'Ordered',1,'2024-04-20'), (2,'Cancelled',2,'2024-09-12'), (3,'Shipped',3,'2025-04-02');

-- Retrieving Data
SELECT * FROM book;
SELECT * FROM customer;

SELECT b.title, a.first_name, a.last_name
FROM book b
INNER JOIN book_author ba ON b.book_id=ba.book_id
INNER JOIN author a ON ba.author_id=a.author_id;

SELECT b.title, p.fullname 
FROM book b
LEFT JOIN publisher p ON b.publisher_id = p.publisher_id;

SELECT c.first_name, c.last_name, co.order_id, co.order_date
FROM customer c
RIGHT JOIN cust_order co ON c.customer_id = co.customer_id;

