SELECT COUNT(*) AS CarsSold, employee.employeeId,
employee.firstName, employee.lastName
FROM sales
INNER JOIN employee ON sales.employeeId = employee.employeeId
GROUP BY employee.employeeId
ORDER BY CarsSold DESC;

SELECT employee.employeeId, employee.firstName, employee.lastName,
MIN(salesAmount) as LeastExpensive, MAX(salesAmount) AS MostExpensive
FROM sales
INNER JOIN employee ON sales.employeeId = employee.employeeId
GROUP BY employee.employeeId;