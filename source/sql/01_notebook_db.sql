-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS notebook_manager;
USE notebook_manager;

-- Create the NoteBook table
CREATE TABLE IF NOT EXISTS note_book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    current_price DOUBLE NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `UK_name` (`name`)
);

-- Insert initial notebook records
INSERT INTO note_book (name, current_price) VALUES
    ('Asus Vivo Book S', 211.9),
    ('HP Inspiron', 299.9),
    ('Dell Magic', 300.0),
    ('Apple MacBook', 709.9),
    ('LG D230', 299.9),
    ('Acer P700', 199.9)
ON DUPLICATE KEY UPDATE
    current_price = VALUES(current_price),
    last_update = CURRENT_TIMESTAMP;
