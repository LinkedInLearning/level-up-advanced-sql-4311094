WITH 
employees AS (
  SELECT
    employeeId,
    firstName,
    LastName
  FROM employee
),
car_sales AS (
  SELECT
    employeeId,
    COUNT(InventoryID)  AS CarsSold
  FROM sales
  GROUP BY employeeId
),
sales_by_employees AS (
  SELECT
    e.employeeId,
    e.firstName,
    e.lastName,
    s.CarsSold
  FROM car_sales AS s
  LEFT JOIN employees AS e
    ON e.employeeId = s.employeeId
)
SELECT * FROM sales_by_employees
ORDER BY CarsSold DESC
