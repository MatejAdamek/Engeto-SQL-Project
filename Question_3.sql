WITH category_price_diff AS (
    SELECT 
        category_name,
        `year`,
        average_annual_price,
        LAG(average_annual_price) OVER (PARTITION BY category_name ORDER BY `year`) AS prev_annual_price
    FROM (
        SELECT 
            category_name,
            AVG(average_price_food) AS average_annual_price,
            `year`
        FROM t_matej_adamek_project_SQL_primary_final 
        GROUP BY category_name, `year`
    ) AS annual_prices
)
SELECT 
    category_name,
    ROUND(AVG((average_annual_price - prev_annual_price) / prev_annual_price * 100), 2) AS average_increase
FROM category_price_diff
WHERE prev_annual_price IS NOT NULL
GROUP BY category_name
ORDER BY average_increase;
