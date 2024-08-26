CREATE VIEW v_matej_adamek_payroll_annual AS
SELECT industry_branch,
       `year`,
       ROUND(AVG(average_wages)) AS average_annual_wage
FROM t_matej_adamek_project_sql_primary_final 
GROUP BY industry_branch, `year`
ORDER BY industry_branch, `year`;



SELECT 
    vmapa.industry_branch,
    SUM(CASE 
        WHEN vmapa.average_annual_wage > vmapa_prev.average_annual_wage THEN 1
        ELSE 0
    END) AS years_with_increase,
    COUNT(*) AS total_years
FROM v_matej_adamek_payroll_annual vmapa
JOIN v_matej_adamek_payroll_annual vmapa_prev
    ON vmapa.industry_branch = vmapa_prev.industry_branch 
    AND vmapa.`year` = vmapa_prev.`year` + 1
GROUP BY vmapa.industry_branch
ORDER BY years_with_increase DESC;
