-- 1. Total orders received
SELECT COUNT(*) AS total_orders
FROM factorders;

-- 2. Cities by orders & revenue
SELECT 
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM dimcustomers c
JOIN factorders o ON c.customer_id = o.customer_id
JOIN factorderitems oi ON o.order_id = oi.order_id
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY c.city
ORDER BY total_revenue DESC, total_orders DESC;

-- 3. Percent of customers using gmail
SELECT 
    COUNT(*) FILTER (WHERE email ILIKE '%@gmail.com') AS gmail_users,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) FILTER (WHERE email ILIKE '%@gmail.com') * 100.0 / COUNT(*), 2) AS gmail_percentage
FROM dimcustomers;

-- 4. Monthly trend of total orders
SELECT 
    EXTRACT(YEAR FROM order_date)  AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(order_id) AS total_orders
FROM factorders
GROUP BY year, month
ORDER BY year, month;

-- 5. Completed, Pending & Cancelled Rate
SELECT 
    status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM factorders
GROUP BY status
ORDER BY order_count DESC;


-- 6. Total revenue
SELECT 
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorderitems oi
JOIN dimproducts p ON oi.product_id = p.product_id;

-- 7. Categories by revenue
SELECT 
    p.category,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorderitems oi
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
-- 8. Top products by revenue
SELECT 
    p.product_name,
    p.category,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorderitems oi
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;

-- 9. AOV and Avg Basket Size
SELECT 
    ROUND(SUM(oi.quantity * p.unit_price) / COUNT(DISTINCT oi.order_id), 2) AS avg_order_value,
    ROUND(AVG(oi.quantity), 2) AS avg_basket_size
FROM factorderitems oi
JOIN dimproducts p ON oi.product_id = p.product_id;

-- 10. Products at risk of stock-out
SELECT 
    p.product_name,
    p.category,
    p.stock,
    SUM(oi.quantity) AS total_sold
FROM factorderitems oi
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.stock
HAVING p.stock < SUM(oi.quantity)
ORDER BY total_sold DESC, p.stock ASC;


