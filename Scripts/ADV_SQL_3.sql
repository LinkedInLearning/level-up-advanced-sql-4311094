-- ADV SQL QRYs -- pt3. Subqueries

-- 9. ----------
-- Find sales of ELECTRIC cars using Subquery


-- i) Join sales & inventory

SELECT *
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId


-- ii) Review model table

SELECT *
FROM model
LIMIT 10;


-- iii) Lookup modelId for ELECTRIC models

SELECT modelId
FROM model
WHERE EngineType = 'Electric';


-- iv) Final query

SELECT sls.soldDate, sls.salesAmount, inv.colour, inv.year
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId
WHERE inv.modelId IN (
  SELECT modelId
  FROM model
  WHERE EngineType = 'Electric'
)



-- 10. ----------
-- For EACH sales person, rank MOST SOLD car models


-- i) Join tables
SELECT emp.firstName, emp.lastName, mdl.model, sls.salesId
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model model
  ON mdl.modelId = inv.modelId


-- ii) Apply grouping
SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model model
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model


-- iii) Add windowing function
SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold,
  rank() OVER (PARTITION BY sls.employeeId
              ORDER BY count(model) desc) AS Rank
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model model
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model



-- 11. ----------
-- Create a report showing Sales Per Month and an Annual Total


-- i) Get data
SELECT strftime('%Y', soldDate) AS soldYear,
  strftime('%m', soldDate) AS soldMonth,
  salesAmount
FROM sales


-- ii) Apply grouping
SELECT strftime('%Y', soldDate) AS soldYear,
  strftime('%m', soldDate) AS soldMonth,
  SUM(salesAmount) AS salesAmount
FROM sales
GROUP BY soldYear, soldMonth
ORDER BY soldYear, soldMonth


-- iii) Add window function - Simplify with CTE
WITH cte_sales AS (
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



-- 12. -------------
-- Display # of cars sold THIS & LAST MONTH


-- i) Get data
SELECT strftime('%Y-%m', soldDate) AS MonthSold,
  COUNT(*) AS NumberCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)


-- ii) Apply window function
SELECT strftime('%Y-%m', soldDate) AS MonthSold,
  COUNT(*) AS NumberCarsSold,
  LAG (COUNT(*), 1, 0 ) OVER calMonth AS LastMonthCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)
WINDOW calMonth AS (ORDER BY strftime('%Y-%m', soldDate))
ORDER BY strftime('%Y-%m', soldDate)