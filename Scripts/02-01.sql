-- How many cars has been sold per employee

-- start with this query
SELECT emp.employeeId, emp.firstName, emp.lastName
FROM sales sls
INNER JOIN employee emp
    ON sls.employeeId = emp.employeeId

-- then add the group by & count
SELECT emp.employeeId, emp.firstName, emp.lastName, count(*) as NumOfCarsSold
FROM sales sls
INNER JOIN employee emp
    ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId, emp.firstName, emp.lastName
ORDER BY NumOfCarsSold DESC;