-- 1. ----------
-- Create a list of employees and their immediate managers

SELECT emp.firstName,
    emp.lastName,
    emp.title,
    mng.firstName AS ManagerFirstName,
    mng.lastName AS ManagerLastName
FROM employee emp
INNER JOIN employee mng
    ON emp.managerID = mng.employeeID


-- 2. ----------
-- Find sales people with 0 Sales

SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, sls.salesId
FROM employee emp
LEFT JOIN sales sls 
    ON emp.employeeId = sls.employeeId
WHERE emp.title = 'Sales Person'
AND sls.salesID IS NULL;


-- 3. ----------
-- List all customers & their sales, even if some data is gone

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
INNER JOIN sales sls 
    ON cus.customerID = sls.customerId
UNION

-- UNION with customers with NO SALES

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus 
LEFT JOIN sales sls 
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION

-- UNION with sales MISSING customer data

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls 
LEFT JOIN customer cus 
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL;


-- 4. ----------
-- How many cars have been sold PER employee

-- Start with
SELECT emp.employeeId, emp.firstName, emp.lastName
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId

-- Add Groupby & Count
SELECT emp.employeeId, emp.firstName, emp.lastName, count(*) as NumOfCarsSold
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId, emp.firstName, emp.lastName
ORDER BY NumOfCarsSold DESC;


-- 5. ----------
-- Find Least & Most expensive car sold by EACH employee THIS year

SELECT emp.employeeId,
    emp.firstName,
    emp.lastName,
    MIN(salesAmount) AS MinSalesAmount,
    MAX(salesAmount) AS MaxSalesAmount
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now', 'start of year')
GROUP BY emp.employeeId, emp.firstName, emp.lastName


-- 6. ----------
-- Display report for employees who have sold AT LEAST 5 cars

SELECT emp.employeeId,
    count(*) AS NumOfCarsSold,
    MIN(salesAmount) AS MinSalesAmount,
    MAX(salesAmount) AS MaxSalesAmount
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now', 'start of year')
GROUP BY emp.employeeId
HAVING count(*) > 5


-- 7. ----------
-- Summarise sales PER year using CTE

WITH cte AS (
SELECT strftime('%Y', soldDate) AS soldYear,
    salesAmount
FROM sales
)
SELECT soldYear
    FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
FROM cte 
GROUP BY soldYear
ORDER BY soldYear


-- 8. ----------
-- Display cars sold for EACH employee by MONTH


-- i)
SELECT emp.firstName, emp.lastName, sls.soldDate, sls.salesAmount
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
AND sls.soldDate < '2022-01-01'


-- ii) Implement Case Statements for each month
SELECT emp.firstName, emp.lastName,
    CASE WHEN strftime('%m', soldDate) = '01'
        THEN salesAmount END AS JanSales,
    CASE
        WHEN strftime('%m', soldDate) = '02'
        THEN salesAmount END AS FebSales,
    CASE
        WHEN strftime('%m', soldDate) = '03'
        THEN salesAmount END AS MarSales,
    CASE
        WHEN strftime('%m', soldDate) = '04'
        THEN salesAmount END AS AprSales,
    CASE
        WHEN strftime('%m', soldDate) = '05'
        THEN salesAmount END AS MaySales,
    CASE
        WHEN strftime('%m', soldDate) = '06'
        THEN salesAmount END AS JunSales,
    CASE
        WHEN strftime('%m', soldDate) = '07'
        THEN salesAmount END AS JulSales,
    CASE
        WHEN strftime('%m', soldDate) = '08'
        THEN salesAmount END AS AugSales,
    CASE
        WHEN strftime('%m', soldDate) = '09'
        THEN salesAmount END AS SepSales,
    CASE
        WHEN strftime('%m', soldDate) = '10'
        THEN salesAmount END AS OctSales,
    CASE
        WHEN strftime('%m', soldDate) = '11'
        THEN salesAmount END AS NovSales,
    CASE
        WHEN strftime('%m', soldDate) = '12'
        THEN salesAmount END AS DecSales,
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
    AND sls.soldDate < '2022-01-01'
ORDER BY emp.lastName, emp.firstName 


-- iii) Group data
SELECT emp.firstName, emp.lastName
    SUM(CASE
          WHEN strftime('%m', soldDate) = '01'
          THEN salesAmount END) AS JanSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '02'
          THEN salesAmount END) AS FebSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '03'
          THEN salesAmount END) AS MarSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '04'
          THEN salesAmount END) AS AprSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '05'
          THEN salesAmount END) AS MaySales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '06'
          THEN salesAmount END) AS JunSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '07'
          THEN salesAmount END) AS JulSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '08'
          THEN salesAmount END) AS AugSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '09'
          THEN salesAmount END) AS SepSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '10'
          THEN salesAmount END) AS OctSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '11'
          THEN salesAmount END) AS NovSales,
    SUM(CASE
          WHEN strftime('%m', soldDate) = '12'
          THEN salesAmount END) AS DecSales,
FROM sales sls 
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
  AND sls.soldDate < '2022-01-01'
GROUP BY emp.firstName, emp.lastName
ORDER BY emp.lastName, emp.firstName