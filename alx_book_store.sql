-- Create the database
CREATE DATABASE IF NOT EXISTS alx_book_store;
USE alx_book_store;

-- Create Authors table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) UNIQUE NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Create Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE NOT NULL,
    publication_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_author (author_id),
    INDEX idx_publication_date (publication_date),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE RESTRICT,
    CONSTRAINT chk_price CHECK (price >= 0)
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_customer (customer_id),
    INDEX idx_order_date (order_date),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE RESTRICT
);

-- Create Order_Details table
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_order (order_id),
    INDEX idx_book (book_id),
    UNIQUE KEY unique_order_book (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT,
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);



#!/usr/bin/env python3
"""
MySQL Database Creation Script for ALX Book Store
Creates the alx_book_store database if it doesn't exist
"""

import mysql.connector
from mysql.connector import Error

def create_database():
    """
    Creates the alx_book_store database in MySQL server
    """
    connection = None
    
    try:
        # Connect to MySQL server (without specifying a database)
        connection = mysql.connector.connect(
            host="localhost",
            user="root",  # Change this to your MySQL username
            password=""   # Change this to your MySQL password
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            try:
                # Create database if it doesn't exist
                create_db_query = "CREATE DATABASE IF NOT EXISTS alx_book_store"
                cursor.execute(create_db_query)
                
                print("Database 'alx_book_store' created successfully!")
                
            except Error as db_error:
                print(f"Error creating database: {db_error}")
            
            finally:
                cursor.close()
                
    except Error as e:
        print(f"Error connecting to MySQL server: {e}")
        
    finally:
        if connection and connection.is_connected():
            connection.close()

if __name__ == "__main__":
    create_database()