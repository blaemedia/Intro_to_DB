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
    create_database()#!/usr/bin/env python3
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
                
            except mysql.connector.Error as db_error:
                print(f"Error creating database: {db_error}")
            
            finally:
                cursor.close()
                
    except mysql.connector.Error as e:
        print(f"Error connecting to MySQL server: {e}")
        
    finally:
        if connection and connection.is_connected():
            connection.close()

if __name__ == "__main__":
    create_database()