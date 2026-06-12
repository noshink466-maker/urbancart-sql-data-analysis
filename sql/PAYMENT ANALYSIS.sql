-- 17. Most frequently used payment methods
SELECT 
    method,
    COUNT(*) AS usage_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM factpayment
GROUP BY method
ORDER BY usage_count DESC;

-- 18. Payment method vs order status
SELECT 
    fp.method,
    o.status,
    COUNT(*) AS order_count
FROM factpayment fp
JOIN factorders o ON fp.order_id = o.order_id
GROUP BY fp.method, o.status
ORDER BY fp.method, order_count DESC;


-- 19. City vs payment method preference
SELECT 
    c.city,
    fp.method,
    COUNT(*) AS usage_count
FROM factpayment fp
JOIN factorders o ON fp.order_id = o.order_id
JOIN dimcustomers c ON o.customer_id = c.customer_id
GROUP BY c.city, fp.method
ORDER BY c.city, usage_count DESC;



-- 20. Order value by payment method
SELECT 
    fp.method,
    ROUND(AVG(order_total), 2) AS avg_order_value,
    ROUND(MAX(order_total), 2) AS max_order_value
FROM factpayment fp
JOIN (
    SELECT oi.order_id, SUM(oi.quantity * p.unit_price) AS order_total
    FROM factorderitems oi
    JOIN dimproducts p ON oi.product_id = p.product_id
    GROUP BY oi.order_id
) ot ON fp.order_id = ot.order_id
GROUP BY fp.method
ORDER BY avg_order_value DESC;


-- 21. Avg items per order by payment method
SELECT 
    fp.method,
    ROUND(AVG(item_count), 2) AS avg_items_per_order
FROM factpayment fp
JOIN (
    SELECT order_id, SUM(quantity) AS item_count
    FROM factorderitems
    GROUP BY order_id
) oi ON fp.order_id = oi.order_id
GROUP BY fp.method
ORDER BY avg_items_per_order DESC;
