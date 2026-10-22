
-- FOOD DELIVERY DATABASE

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS FOODDELIVERY;

-- 2. USE DATABASE
USE FOODDELIVERY;


-- 3. CUSTOMERS TABLE

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active'
);

DESCRIBE Customers;


-- 4. RESTAURANTS TABLE


CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    rating DECIMAL(2,1) DEFAULT 0.0,
    gst_number VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('Open', 'Closed', 'Temporarily Closed') DEFAULT 'Open'
);

DESCRIBE Restaurants;


-- 5. CATEGORIES TABLE


CREATE TABLE IF NOT EXISTS Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

DESCRIBE Categories;



-- 6. DELIVERY PARTNERS TABLE


CREATE TABLE IF NOT EXISTS Delivery_Partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL,
    license_number VARCHAR(30) UNIQUE NOT NULL,
    joining_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);

DESCRIBE Delivery_Partners;


-- 7. MENU TABLE


CREATE TABLE IF NOT EXISTS Menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    is_veg BOOLEAN DEFAULT TRUE,
    preparation_time INT NOT NULL,
    availability VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id),

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);

DESCRIBE Menu;



-- 8. ORDERS TABLE


CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    delivery_partner_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    delivery_charge DECIMAL(10,2) DEFAULT 0.00,
    discount DECIMAL(10,2) DEFAULT 0.00,
    tax DECIMAL(10,2) DEFAULT 0.00,
    final_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30) DEFAULT 'Pending',
    payment_status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id),

    FOREIGN KEY (delivery_partner_id)
        REFERENCES Delivery_Partners(partner_id)
);

DESCRIBE Orders;


-- 9. ORDER ITEMS TABLE

CREATE TABLE IF NOT EXISTS Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (menu_id)
        REFERENCES Menu(menu_id)
);

DESCRIBE Order_Items;


-- 10. PAYMENTS TABLE


CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100) UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);

DESCRIBE Payments;


-- 11. RATINGS TABLE


CREATE TABLE IF NOT EXISTS Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL,
    review VARCHAR(500),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CHECK (rating BETWEEN 1 AND 5)
);

DESCRIBE Ratings;



-- 12. SHOW ALL TABLES


SHOW TABLES;