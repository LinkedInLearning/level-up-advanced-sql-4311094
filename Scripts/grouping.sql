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

SELECT COUNT(*) AS CarsSold, employee.employeeId,
employee.firstName, employee.lastName
FROM sales
INNER JOIN employee ON sales.employeeId = employee.employeeId
WHERE (soldDate BETWEEN '2022-01-01%' AND '2022-12-13%') 
GROUP BY employee.employeeId
HAVING CarsSold >= 5
ORDER BY CarsSold DESC;