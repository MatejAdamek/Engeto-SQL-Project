SELECT tma.`year`,
	   tma2.`year` AS prev_year,
	   round(( tma.price_year - tma2.price_prev_year)/tma2.price_prev_year*100,2) AS price_diff,
	   round((tma.wages_year - tma2.wages_prev_year)/tma2.wages_prev_year*100,2) AS wages_diff,
	   round(( tma.price_year - tma2.price_prev_year)/tma2.price_prev_year*100-(tma.wages_year - tma2.wages_prev_year)/tma2.wages_prev_year*100,2) AS percent_diff
FROM (
	SELECT `year` ,
			round(avg(average_price_food)) AS price_year,
			round(avg(average_wages)) AS wages_year		
	FROM t_matej_adamek_project_SQL_primary_final
	GROUP BY `year`) AS tma
JOIN (
	SELECT `year` ,
			round(avg(average_price_food)) AS price_prev_year,
			round(avg(average_wages)) AS wages_prev_year		
	FROM t_matej_adamek_project_SQL_primary_final
	GROUP BY `year`) AS tma2
	ON tma.`year`= tma2.`year`+1
ORDER BY tma.`year`DESC;

