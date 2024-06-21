-- Find the least and most expensive car sold by each employee this year

SELECT emp.employeeId, 
    emp.firstName, 
    emp.lastName, 
    MIN(salesAmount) AS MinSalesAmount, 
    MAX(salesAmount) as MaxSalesAmount
FROM sales sls
INNER JOIN employee emp
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date(2022-01-01)
GROUP BY emp.employeeId, emp.firstName, emp.lastName


