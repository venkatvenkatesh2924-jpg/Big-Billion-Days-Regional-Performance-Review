-- What are completed-order revenue metrics by customer region and month?
-- INNER JOIN keeps only customers with matching orders; COUNT(DISTINCT o.customer_id) counts each customer once even if they placed multiple orders in the same region-month.
SELECT
    c.region AS region,
    o.order_month AS order_month,
    COUNT(*) AS number_of_orders,
    COUNT(DISTINCT o.customer_id) AS number_of_customers,
    SUM(o.amount) AS total_revenue,
    AVG(o.amount) AS average_revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.region, o.order_month
ORDER BY c.region ASC, o.order_month ASC;
