WITH year_data AS (
    SELECT 
        tma.`year`,
        tma.price_year,
        tma.wages_year,
        tma2.price_prev_year,
        tma2.wages_prev_year,
        gdp.gdp,
        LAG(gdp.gdp) OVER (ORDER BY tma.`year`) AS prev_gdp
    FROM (
        SELECT 
            `year`,
            ROUND(AVG(average_price_food), 2) AS price_year,
            ROUND(AVG(average_wages), 2) AS wages_year
        FROM t_matej_adamek_project_SQL_primary_final
        GROUP BY `year`
    ) AS tma
    JOIN (
        SELECT 
            `year`,
            ROUND(AVG(average_price_food), 2) AS price_prev_year,
            ROUND(AVG(average_wages), 2) AS wages_prev_year
        FROM t_matej_adamek_project_SQL_primary_final
        GROUP BY `year`
    ) AS tma2
    ON tma.`year` = tma2.`year` + 1
    JOIN (
        SELECT 
            `year`,
            gdp
        FROM t_matej_adamek_project_SQL_secondary_final
        WHERE country = 'Czech Republic'
    ) AS gdp
    ON tma.`year` = gdp.`year`
)
SELECT 
    `year`,
    price_year,
    price_prev_year,
    ROUND((price_year - price_prev_year) / price_prev_year * 100, 2) AS price_growth_perc,
    wages_year,
    wages_prev_year,
    ROUND((wages_year - wages_prev_year) / wages_prev_year * 100, 2) AS wages_growth_perc,
    gdp,
    prev_gdp,
    ROUND((gdp - prev_gdp) / prev_gdp * 100, 2) AS gdp_growth_perc
FROM year_data
ORDER BY `year` DESC;
