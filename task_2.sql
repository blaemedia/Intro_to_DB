-- Task 2: Create Tables for ALX Book Store Database
-- This script creates all necessary tables for the online bookstore

USE alx_book_store;

-- Create AUTHORS table
CREATE TABLE IF NOT EXISTS AUTHORS (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
);

-- Create CUSTOMERS table
CREATE TABLE IF NOT EXISTS CUSTOMERS (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) UNIQUE NOT NULL,
    address TEXT
);

-- Create BOOKS table
CREATE TABLE IF NOT EXISTS BOOKS (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE NOT NULL,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES AUTHORS(author_id) ON DELETE RESTRICT
);

-- Create ORDERS table
CREATE TABLE IF NOT EXISTS ORDERS (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id) ON DELETE RESTRICT
);

-- Create ORDER_DETAILS table
CREATE TABLE IF NOT EXISTS ORDER_DETAILS (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES BOOKS(book_id) ON DELETE RESTRICT,
    UNIQUE KEY (order_id, book_id)
);

-- Optional: Add indexes for better performance
CREATE INDEX idx_books_author ON BOOKS(author_id);
CREATE INDEX idx_books_title ON BOOKS(title);
CREATE INDEX idx_customers_email ON CUSTOMERS(email);
CREATE INDEX idx_orders_customer ON ORDERS(customer_id);
CREATE INDEX idx_orders_date ON ORDERS(order_date);
CREATE INDEX idx_order_details_order ON ORDER_DETAILS(order_id);
CREATE INDEX idx_order_details_book ON ORDER_DETAILS(book_id);