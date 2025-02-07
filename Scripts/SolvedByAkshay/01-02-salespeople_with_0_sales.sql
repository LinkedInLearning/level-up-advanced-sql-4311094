WITH
Salespeople AS(
  SELECT
    employeeId,
    firstName,
    lastName,
    title,
    startDate
  FROM employee
  WHERE title = 'Sales Person'
),
Salespeople_Sales AS (
  SELECT 
    e.employeeId,
    e.firstName,
    e.lastName,
    e.title,
    e.startDate,
    s.salesAmount 
  FROM Salespeople AS e
  LEFT JOIN sales AS s
    ON e.employeeId = s.employeeId
)
SELECT * FROM Salespeople_Sales
WHERE salesAmount IS NULL
 