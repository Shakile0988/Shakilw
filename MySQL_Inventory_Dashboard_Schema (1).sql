
-- MySQL Schema for Inventory Management Dashboard

-- Table: categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table: products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category_id INT,
    quantity_in_stock INT DEFAULT 0,
    price DECIMAL(10, 2),
    added_date DATE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Table: suppliers
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact_info TEXT
);

-- Table: purchases
CREATE TABLE purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    supplier_id INT,
    quantity INT,
    purchase_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Table: sales
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_price DECIMAL(10, 2),
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- View: dashboard_summary (for visualization)
CREATE VIEW dashboard_summary AS
SELECT 
    p.name AS product_name,
    c.name AS category_name,
    p.quantity_in_stock,
    p.price,
    IFNULL(SUM(s.quantity), 0) AS total_sales,
    IFNULL(SUM(pr.quantity), 0) AS total_purchased
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
LEFT JOIN sales s ON p.product_id = s.product_id
LEFT JOIN purchases pr ON p.product_id = pr.product_id
GROUP BY p.product_id;
