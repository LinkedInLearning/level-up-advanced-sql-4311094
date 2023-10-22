select * from sales s limit 10;

WITH cte AS (
  SELECT strftime('%Y', s.soldDate) AS 'soldYear', s.salesAmount FROM sales s)
SELECT soldYear, FORMAT("$%.2f", SUM(salesAmount)) as 'AnnualSale'
FROM cte 
GROUP BY soldYear
ORDER BY soldYear;