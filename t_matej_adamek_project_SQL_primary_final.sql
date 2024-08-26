CREATE TABLE t_matej_adamek_project_SQL_primary_final AS
SELECT cf.category_food_code,
	   cf.category_name,
	   cf.average_price_food,
	   cf.year_food AS year,
	   cpay.industry_branch_code,
	   cpay.industry_branch,
	   cpay. average_wages
FROM (
	SELECT round(avg(cp.value)) AS average_price_food,
			cp.category_code AS category_food_code,
			cpc.name AS category_name,
			YEAR(cp.date_from) AS year_food
	FROM czechia_price cp 
	JOIN czechia_price_category cpc 
		ON cp.category_code = cpc.code
	GROUP BY cp.category_code ,YEAR(cp.date_from)
	) AS cf
JOIN (
	SELECT cp1.industry_branch_code,
		   cpib.name AS industry_branch,
		   cp1. average_wages,
		   cp1.payroll_year		
	FROM czechia_payroll_industry_branch cpib 
	JOIN (
			SELECT industry_branch_code,
					payroll_year,
					round(avg(value)) AS average_wages  
			FROM czechia_payroll cp 
			WHERE value_type_code = 5958
				AND calculation_code = 200
					AND industry_branch_code IS NOT NULL
			GROUP BY payroll_year, industry_branch_code) AS cp1
		ON cpib.code = cp1.industry_branch_code) AS cpay
		ON cf.year_food=cpay.payroll_year
	ORDER BY category_food_code, year DESC;