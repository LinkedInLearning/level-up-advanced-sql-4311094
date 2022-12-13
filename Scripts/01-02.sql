-- Find sales people who have zero sales

SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, sls.salesId
FROM employee emp
LEFT JOIN sales sls
    ON emp.employeeId = sls.employeeId
WHERE emp.title = 'Sales Person'
AND sls.salesId IS NULL;
