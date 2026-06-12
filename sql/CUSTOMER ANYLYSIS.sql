-- 11. Customers by total revenue
SELECT 
    c.full_name,
    c.city,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorders o
JOIN dimcustomers c ON o.customer_id = c.customer_id
JOIN factorderitems oi ON o.order_id = oi.order_id
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.full_name, c.city
ORDER BY total_revenue DESC
LIMIT 10;

-- 12a. Cancellation rate by city
SELECT 
    c.city,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE o.status = 'Cancelled') AS cancelled,
    ROUND(COUNT(*) FILTER (WHERE o.status = 'Cancelled') * 100.0 / COUNT(*), 2) AS cancel_rate
FROM factorders o
JOIN dimcustomers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY cancel_rate DESC;

-- 12b. Cancellation rate by customer
SELECT 
    c.full_name,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE o.status = 'Cancelled') AS cancelled,
    ROUND(COUNT(*) FILTER (WHERE o.status = 'Cancelled') * 100.0 / COUNT(*), 2) AS cancel_rate
FROM factorders o
JOIN dimcustomers c ON o.customer_id = c.customer_id
GROUP BY c.full_name
ORDER BY cancel_rate DESC;

-- 13. Purchasing patterns by gender & category
SELECT 
    c."Gender",
    p.category,
    COUNT(*) AS orders_count,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorders o
JOIN dimcustomers c ON o.customer_id = c.customer_id
JOIN factorderitems oi ON o.order_id = oi.order_id
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY c."Gender", p.category
ORDER BY c."Gender", total_revenue DESC;

-- 14. Purchasing behavior since account creation
SELECT 
    c.customer_id,
    c.full_name,
    c.created_at AS account_created,
    DATE_TRUNC('month', o.order_date) AS order_month,
    COUNT(o.order_id) AS orders_in_month,
    SUM(oi.quantity * p.unit_price) AS revenue_in_month
FROM dimcustomers c
JOIN factorders o ON c.customer_id = o.customer_id
JOIN factorderitems oi ON o.order_id = oi.order_id
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.full_name, c.created_at, DATE_TRUNC('month', o.order_date)
ORDER BY c.customer_id, order_month;


-- 15. Ordered in October but not December
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM dimcustomers c
JOIN factorders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = 10
AND c.customer_id NOT IN (
    SELECT customer_id 
    FROM factorders 
    WHERE EXTRACT(MONTH FROM order_date) = 12
);

-- 16. Ordered in BOTH October & December
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM dimcustomers c
JOIN factorders o ON c.customer_id = o.customer_id
WHERE EXTRACT(MONTH FROM o.order_date) = 10
AND c.customer_id IN (
    SELECT customer_id 
    FROM factorders 
    WHERE EXTRACT(MONTH FROM order_date) = 12
);
