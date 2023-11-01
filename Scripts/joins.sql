-- list of employees, inclduing first and last names, and the first and last name of their immediate manager

SELECT 
employee.employeeId,
employee.firstName AS 'Employee First Name',
employee.lastName AS 'Employee Last Name',
manager.firstName AS 'Manager First Name',
manager.lastName AS 'Manager Last Name'
FROM employee employee
JOIN employee manager
ON employee.managerId = manager.employeeId;


SELECT employee.employeeId, employee.firstName, employee.lastName, 
employee.title, sales.salesId AS TotalSales
FROM employee
LEFT JOIN sales ON employee.employeeId = sales.employeeId
WHERE employee.title = 'Sales Person' 
AND sales.salesId IS NULL;

SELECT customer.customerId, customer.firstName, customer.lastName, sales.salesId
FROM customer
INNER JOIN sales on customer.customerId = sales.customerId
UNION
SELECT customer.customerId, customer.firstName, customer.lastName, sales.salesId
FROM customer
LEFT JOIN sales on customer.customerId = sales.customerId
WHERE sales.salesId IS NULL
UNION
SELECT customer.customerId, customer.firstName, customer.lastName, sales.salesId
FROM sales
LEFT JOIN customer on customer.customerId = sales.customerId
WHERE sales.salesId IS NULL;
