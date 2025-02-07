WITH
sales_people AS(
  SELECT
    employeeid,
    firstname,
    lastname
  FROM employee
),
sales_2021 AS(
  SELECT
    employeeId,
    strftime('%m', soldDate) AS Month,
    salesAmount AS MonthlySale
  FROM sales
  WHERE strftime('%Y', soldDate) = '2021'
  GROUP BY employeeId, strftime('%m', soldDate)
),
sales_pivoted AS(
  SELECT
    employeeId,
    SUM(CASE WHEN month = '01' THEN MonthlySale ELSE 0 END) AS JanSales,
    SUM(CASE WHEN month = '02' THEN Monthlysale ELSE 0 END) AS FebSales,
    SUM(CASE WHEN month = '03' THEN Monthlysale ELSE 0 END) AS MarSales,
    SUM(CASE WHEN month = '04' THEN Monthlysale ELSE 0 END) AS AprSales,
    SUM(CASE WHEN month = '05' THEN Monthlysale ELSE 0 END) AS MaySales,
    SUM(CASE WHEN month = '06' THEN Monthlysale ELSE 0 END) AS JunSales,
    SUM(CASE WHEN month = '07' THEN Monthlysale ELSE 0 END) AS JulSales,
    SUM(CASE WHEN month = '08' THEN Monthlysale ELSE 0 END) AS AugSales,
    SUM(CASE WHEN month = '09' THEN Monthlysale ELSE 0 END) AS SepSales,
    SUM(CASE WHEN month = '10' THEN Monthlysale ELSE 0 END) AS OctSales,
    SUM(CASE WHEN month = '11' THEN Monthlysale ELSE 0 END) AS NovSales,
    SUM(CASE WHEN month = '12' THEN Monthlysale ELSE 0 END) AS DecSales
    
  FROM sales_2021
  
  GROUP By employeeId 
  
)
SELECT e.firstName, e.lastName, s.* FROM sales_pivoted AS s
LEFT JOIN sales_people AS e
  ON s.employeeId = e.employeeId


