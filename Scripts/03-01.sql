-- Summarise sales per year by using a CTE

WITH cte AS (
SELECT strftime('%Y', soldDate) AS soldYear, salesAmount
FROM sales
)
SELECT soldYear, FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
FROM cte
GROUP BY soldYear
ORDER BY soldYear

-- FORMAT("$%.2f" - does 2 decimal points and handles any rounding
-- can use ,d to get commas to seperate 100's ... but can't combine these currently