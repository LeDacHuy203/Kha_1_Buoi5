-- =========================================
-- CREATE DATABASE
-- =========================================
CREATE DATABASE Kha_1_Buoi5;
-- =========================================
-- CREATE SCHEMA
-- =========================================
CREATE SCHEMA session05;

SET search_path TO session05;

-- =========================================
-- TABLE: products
-- =========================================
CREATE TABLE products
(
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(100) NOT NULL
);

-- =========================================
-- TABLE: orders
-- =========================================
CREATE TABLE orders
(
    order_id    INT PRIMARY KEY,
    product_id  INT            NOT NULL,
    quantity    INT            NOT NULL CHECK (quantity > 0),
    total_price NUMERIC(12, 2) NOT NULL CHECK (total_price >= 0),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)

);

-- =========================================
-- INSERT DATA: products
-- =========================================
INSERT INTO products (product_id, product_name, category)
VALUES (1, 'Laptop Dell', 'Electronics'),
       (2, 'IPhone 15', 'Electronics'),
       (3, 'Bàn học gỗ', 'Furniture'),
       (4, 'Ghế xoay', 'Furniture');

-- =========================================
-- INSERT DATA: orders
-- =========================================
INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES (101, 1, 2, 2200),
       (102, 2, 3, 3300),
       (103, 3, 5, 2500),
       (104, 4, 4, 1600),
       (105, 1, 1, 1100);

-- =========================================
-- VIEW DATA
-- =========================================
SELECT *
FROM products;

SELECT *
FROM orders;
-- 1.Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- Đặt bí danh cột như sau:
-- total_sales cho tổng doanh thu
-- total_quantity cho tổng số lượng
SELECT p.category, sum(total_price) as total_sales, sum(quantity) as total_quantity
FROM orders o
         JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;
-- 2.Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
SELECT p.category,
       SUM(o.total_price) AS total_sales
FROM orders o
         JOIN products p
              ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000;
-- 3.Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT p.category,
       SUM(o.total_price) AS total_sales
FROM orders o
         JOIN products p
              ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;


