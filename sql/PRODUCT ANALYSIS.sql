-- 22. Difference between category avg price and product price
SELECT 
    p.product_name,
    p.category,
    p.unit_price,
    ROUND(AVG(p.unit_price) OVER (PARTITION BY p.category), 2) AS category_avg_price,
    ROUND(p.unit_price - AVG(p.unit_price) OVER (PARTITION BY p.category), 2) AS price_difference
FROM dimproducts p
ORDER BY p.category, price_difference DESC;



-- 23. Most frequent product pairs ordered together
SELECT 
    a.product_id AS product_1,
    b.product_id AS product_2,
    COUNT(*) AS times_bought_together
FROM factorderitems a
JOIN factorderitems b 
    ON a.order_id = b.order_id 
    AND a.product_id < b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY times_bought_together DESC
LIMIT 10;


-- 24. Product pairs generating highest revenue together
SELECT 
    pa.product_name AS product_1,
    pb.product_name AS product_2,
    SUM((a.quantity * pa.unit_price) + (b.quantity * pb.unit_price)) AS combined_revenue
FROM factorderitems a
JOIN factorderitems b 
    ON a.order_id = b.order_id 
    AND a.product_id < b.product_id
JOIN dimproducts pa ON a.product_id = pa.product_id
JOIN dimproducts pb ON b.product_id = pb.product_id
GROUP BY pa.product_name, pb.product_name
ORDER BY combined_revenue DESC
LIMIT 10;


-- 25. Daily report
SELECT 
    o.order_date AS date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_items,
    COUNT(DISTINCT o.order_id) FILTER (WHERE o.status = 'Completed') AS completed_orders,
    COUNT(DISTINCT o.order_id) FILTER (WHERE o.status = 'Cancelled') AS cancelled_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM factorders o
JOIN factorderitems oi ON o.order_id = oi.order_id
JOIN dimproducts p ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;
