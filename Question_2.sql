SELECT 
    category_name,
    ROUND(AVG(average_wages) / AVG(average_price_food), 2) AS annual_purchase,
    `year`
FROM t_matej_adamek_project_sql_primary_final 
WHERE (LOWER(category_name) LIKE '%chleb%' OR LOWER(category_name) LIKE '%mleko%')
    AND `year` IN (2006, 2018)
GROUP BY category_name, `year`
ORDER BY category_name, `year`;
