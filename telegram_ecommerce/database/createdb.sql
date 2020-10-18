

CREATE DATABASE IF NOT EXISTS telegram_ecommerce;
USE telegram_ecommerce;


DELIMITER $$


CREATE PROCEDURE create_customers_table()
BEGIN
    CREATE TABLE IF NOT EXISTS customers (
        chat_id INT PRIMARY KEY,
        username VARCHAR(30) NOT NULL,
        password_hash VARCHAR(10),
        is_admin BOOLEAN NOT NULL DEFAULT FALSE
    );
END $$


CREATE PROCEDURE create_category_table()
BEGIN
    CREATE TABLE IF NOT EXISTS category (
        category_id INT AUTO_INCREMENT PRIMARY KEY,
        category_name VARCHAR(30) NOT NULL,
        category_description VARCHAR(500) NOT NULL,
        tags VARCHAR(100),
        image BLOB
    );
END $$


CREATE PROCEDURE create_products_table()
BEGIN
    CREATE TABLE IF NOT EXISTS products (
        product_id INT AUTO_INCREMENT PRIMARY KEY, 
        name VARCHAR(30) NOT NULL,
        unit_price FLOAT NOT NULL,
        quantity_in_stock INT NOT NULL,
        category_id INT NOT NULL,
        image BLOB,
        FOREIGN KEY (category_id)
        REFERENCES category (category_id)
    );
END $$


CREATE PROCEDURE create_orders_table()
BEGIN
    CREATE TABLE IF NOT EXISTS orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        price FLOAT NOT NULL,
        quantity INT NOT NULL,
        total_price FLOAT GENERATED ALWAYS AS (quantity * price),
        chat_id INT,
        product_id INT,
        FOREIGN KEY (chat_id)
        REFERENCES customers (chat_id),
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
    );
END $$


CREATE PROCEDURE create_all_tables()
BEGIN
    CALL create_customers_table();
    CALL create_category_table();
    CALL create_products_table();
    CALL create_orders_table();
END $$


DELIMITER ;

