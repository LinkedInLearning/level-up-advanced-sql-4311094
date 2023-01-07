-- Create a report showing sales per month and an annual total

-- get the needed data
SELECT strftime('%Y', soldDate) AS soldYear, 
  strftime('%m', soldDate) AS soldMonth, 
  salesAmount
FROM sales

-- apply the grouping
SELECT strftime('%Y', soldDate) AS soldYear, 
  strftime('%m', soldDate) AS soldMonth,
  SUM(salesAmount) AS salesAmount
FROM sales
GROUP BY soldYear, soldMonth
ORDER BY soldYear, soldMonth

-- add the window function - simplify with cte
with cte_sales as (
SELECT strftime('%Y', soldDate) AS soldYear, 
  strftime('%m', soldDate) AS soldMonth,
  SUM(salesAmount) AS salesAmount
FROM sales
GROUP BY soldYear, soldMonth
)
SELECT soldYear, soldMonth, salesAmount,
  SUM(salesAmount) OVER (
    PARTITION BY soldYear 
    ORDER BY soldYear, soldMonth) AS AnnualSales_RunningTotal
FROM cte_sales
ORDER BY soldYear, soldMonth
