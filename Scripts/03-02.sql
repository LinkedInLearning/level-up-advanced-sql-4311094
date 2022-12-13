-- Display cars sold for each employee by month

-- 1. start with a query to get the needed data
SELECT emp.firstName, emp.lastName, sls.soldDate, sls.salesAmount
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
AND sls.soldDate < '2022-01-01'


-- 2. implement case statements for each month
SELECT emp.firstName, emp.lastName,
  CASE WHEN strftime('%m', soldDate) = '01' THEN salesAmount END AS JanSales,
  CASE WHEN strftime('%m', soldDate) = '02' THEN salesAmount END AS FebSales,
  CASE WHEN strftime('%m', soldDate) = '03' THEN salesAmount END AS MarSales,
  CASE WHEN strftime('%m', soldDate) = '04' THEN salesAmount END AS AprSales,
  CASE WHEN strftime('%m', soldDate) = '05' THEN salesAmount END AS MaySales,
  CASE WHEN strftime('%m', soldDate) = '06' THEN salesAmount END AS JunSales,
  CASE WHEN strftime('%m', soldDate) = '07' THEN salesAmount END AS JulSales,
  CASE WHEN strftime('%m', soldDate) = '08' THEN salesAmount END AS AugSales,
  CASE WHEN strftime('%m', soldDate) = '09' THEN salesAmount END AS SepSales,
  CASE WHEN strftime('%m', soldDate) = '10' THEN salesAmount END AS OctSales,
  CASE WHEN strftime('%m', soldDate) = '11' THEN salesAmount END AS NovSales,
  CASE WHEN strftime('%m', soldDate) = '12' THEN salesAmount END AS DecSales
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
  AND sls.soldDate < '2022-01-01'
ORDER BY emp.lastName, emp.firstName

-- 3. finally group the data
SELECT emp.firstName, emp.lastName,
  sum(CASE WHEN strftime('%m', soldDate) = '01' THEN salesAmount END) AS JanSales,
  sum(CASE WHEN strftime('%m', soldDate) = '02' THEN salesAmount END) AS FebSales,
  sum(CASE WHEN strftime('%m', soldDate) = '03' THEN salesAmount END) AS MarSales,
  sum(CASE WHEN strftime('%m', soldDate) = '04' THEN salesAmount END) AS AprSales,
  sum(CASE WHEN strftime('%m', soldDate) = '05' THEN salesAmount END) AS MaySales,
  sum(CASE WHEN strftime('%m', soldDate) = '06' THEN salesAmount END) AS JunSales,
  sum(CASE WHEN strftime('%m', soldDate) = '07' THEN salesAmount END) AS JulSales,
  sum(CASE WHEN strftime('%m', soldDate) = '08' THEN salesAmount END) AS AugSales,
  sum(CASE WHEN strftime('%m', soldDate) = '09' THEN salesAmount END) AS SepSales,
  sum(CASE WHEN strftime('%m', soldDate) = '10' THEN salesAmount END) AS OctSales,
  sum(CASE WHEN strftime('%m', soldDate) = '11' THEN salesAmount END) AS NovSales,
  sum(CASE WHEN strftime('%m', soldDate) = '12' THEN salesAmount END) AS DecSales
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
  AND sls.soldDate < '2022-01-01'
GROUP BY emp.firstName, emp.lastName
ORDER BY emp.lastName, emp.firstName
