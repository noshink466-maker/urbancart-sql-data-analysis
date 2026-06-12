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

