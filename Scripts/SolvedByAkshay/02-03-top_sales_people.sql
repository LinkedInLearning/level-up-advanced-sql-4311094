WITH
Car_Price_By_Salesperson AS (
SELECT 
  employeeId, 
  COUNT(*) AS CarsSold, 
  MAX(salesAmount) AS expensive, 
  MIN(salesAmount) AS Cheapest 
FROM sales
WHERE  date(soldDate) >= '2023-01-01'
GROUP BY employeeID
HAVING COUNT(*) > 5
),
Salesperson AS (
  SELECT
    employeeId,
    firstName,
    lastName
  FROM employee
),
joined AS(
  SELECT
    e.employeeId,
    e.firstName,
    e.lastName,
    s.CarsSold,
    s.Expensive,
    s.Cheapest 
  FROM Car_Price_By_Salesperson AS s
  LEFT JOIN Salesperson AS e
  ON s.employeeId = e.employeeId
)
SELECT * FROM joined