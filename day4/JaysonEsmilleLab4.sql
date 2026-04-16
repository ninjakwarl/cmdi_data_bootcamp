CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name TEXT,
    email TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price NUMERIC
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    status TEXT
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_price NUMERIC
);

-- Customers
INSERT INTO customers (full_name, email)
SELECT
    'Customer_' || i,
    'customer_' || i || '@email.com'
FROM generate_series(1, 10000) i;

-- Products
INSERT INTO products (product_name, category, price)
SELECT
    'Product_' || i,
    CASE
        WHEN i % 3 = 0 THEN 'Electronics'
        WHEN i % 3 = 1 THEN 'Clothing'
        ELSE 'Home'
    END,
    (random()*5000)::numeric
FROM generate_series(1, 2000) i;

-- Orders
INSERT INTO orders (customer_id, order_date, status)
SELECT
    (random()*10000)::int + 1,
    CURRENT_DATE - (random()*365)::int,
    CASE
        WHEN random() < 0.7 THEN 'Completed'
        ELSE 'Pending'
    END
FROM generate_series(1, 300000);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, total_price)
SELECT
    (random()*300000)::int + 1,
    (random()*2000)::int + 1,
    (random()*5)::int + 1,
    (random()*10000)::numeric
FROM generate_series(1, 500000);

EXPLAIN ANALYZE
SELECT
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.total_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
AND oi.total_price > 500
GROUP BY c.full_name
ORDER BY total_spent DESC
LIMIT 10;

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_price ON order_items(total_price);

BEGIN;

UPDATE products
SET price = price - 100
WHERE product_id = 1;

-- Simulate system error
UPDATE orders
SET status = 'Completed'
WHERE order_id = 999999; -- does not exist

ROLLBACK;

ALTER TABLE products
ADD CONSTRAINT price_positive CHECK (price > 0);

UPDATE products SET price = -500 WHERE product_id = 1;

CREATE TABLE orders_partitioned (
    order_id INT,
    customer_id INT,
    order_date DATE,
    status TEXT
) PARTITION BY RANGE (order_date);

CREATE TABLE orders_2023 PARTITION OF orders_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE orders_2024 PARTITION OF orders_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

INSERT INTO orders_partitioned
SELECT * FROM orders
WHERE order_date >= '2023-01-01'
LIMIT 100000;

EXPLAIN ANALYZE
SELECT *
FROM orders_partitioned
WHERE order_date = '2023-06-01';

SHOW work_mem;
SHOW shared_buffers;
SHOW effective_cache_size;

EXPLAIN ANALYZE

SELECT
    p.category,
    SUM(oi.total_price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;