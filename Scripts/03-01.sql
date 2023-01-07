-- Summarise sales per year by using a CTE

WITH cte AS (
SELECT strftime('%Y', soldDate) AS soldYear, 
  salesAmount
FROM sales
)
SELECT soldYear, 
  FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
FROM cte
GROUP BY soldYear
ORDER BY soldYear
