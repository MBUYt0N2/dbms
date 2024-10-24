CREATE DATABASE shop_db;

USE shop_db;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10, 2),
    order_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (name, email) VALUES
    ('Alice Smith', 'alice@example.com'),
    ('Bob Johnson', 'bob@example.com');
    
INSERT INTO orders (customer_id, order_amount, order_date) VALUES
(1, 100.50, NOW()),
(1, 200.75, NOW()),
(2, 150.00, NOW());