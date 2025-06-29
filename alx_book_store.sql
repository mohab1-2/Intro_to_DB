-- A Magical Database for Your Dream Online Bookstore Adventure!
-- Database Name: alx_book_store

-- Create the database
CREATE DATABASE IF NOT EXISTS alx_book_store;
USE alx_book_store;

-- ========================================
-- AUTHORS TABLE
-- ========================================
-- Stores information about authors
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(215) NOT NULL
);

-- ========================================
-- CUSTOMERS TABLE
-- ========================================
-- Stores information about customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL UNIQUE,
    address TEXT
);

-- ========================================
-- BOOKS TABLE
-- ========================================
-- Stores information about books available in the bookstore
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(130) NOT NULL,
    author_id INT,
    price DOUBLE NOT NULL,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- ========================================
-- ORDERS TABLE
-- ========================================
-- Stores information about orders placed by customers
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- ========================================
-- ORDER_DETAILS TABLE
-- ========================================
-- Stores information about the books included in each order
CREATE TABLE Order_Details (
    orderdetailid INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- ========================================
-- SAMPLE DATA INSERTION (Optional)
-- ========================================

-- Insert sample authors
INSERT INTO Authors (author_name) VALUES
('J.K. Rowling'),
('George R.R. Martin'),
('Stephen King'),
('Agatha Christie'),
('Harper Lee');

-- Insert sample customers
INSERT INTO Customers (customer_name, email, address) VALUES
('Alice Johnson', 'alice@email.com', '123 Main St, New York, NY'),
('Bob Smith', 'bob@email.com', '456 Oak Ave, Los Angeles, CA'),
('Carol Davis', 'carol@email.com', '789 Pine Rd, Chicago, IL'),
('David Wilson', 'david@email.com', '321 Elm St, Houston, TX');

-- Insert sample books
INSERT INTO Books (title, author_id, price, publication_date) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 12.99, '1997-06-26'),
('A Game of Thrones', 2, 15.99, '1996-08-01'),
('The Shining', 3, 13.50, '1977-01-28'),
('Murder on the Orient Express', 4, 11.99, '1934-01-01'),
('To Kill a Mockingbird', 5, 14.99, '1960-07-11');

-- Insert sample orders
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-06-15'),
(2, '2024-06-16'),
(1, '2024-06-17'),
(3, '2024-06-18');

-- Insert sample order details
INSERT INTO Order_Details (order_id, book_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(2, 4, 1),
(3, 5, 1),
(4, 1, 1),
(4, 2, 1),
(4, 3, 1);

-- ========================================
-- VERIFICATION QUERIES
-- ========================================

-- Display all tables
SHOW TABLES;

-- Display table structures
DESCRIBE Authors;
DESCRIBE Customers;
DESCRIBE Books;
DESCRIBE Orders;
DESCRIBE Order_Details;

-- Sample queries to verify data
SELECT 'Books with Authors:' AS Query_Description;
SELECT b.title, a.author_name, b.price, b.publication_date
FROM Books b
JOIN Authors a ON b.author_id = a.author_id;

SELECT 'Customer Orders:' AS Query_Description;
SELECT c.customer_name, o.order_id, o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

SELECT 'Order Details with Book Information:' AS Query_Description;
SELECT od.orderdetailid, o.order_id, b.title, od.quantity, b.price,
       (od.quantity * b.price) AS subtotal
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Books b ON od.book_id = b.book_id;