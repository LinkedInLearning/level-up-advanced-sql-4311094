SELECT *
FROM employee
LIMIT 5;
Go
SELECT * 
FROM model
LIMIT 5;

SELECT sql
FROM sqlite_schema
WHERE name= 'employee';

# Make a list of employees and their immediate managers
SELECT emp.firstName AS employee_first_name,emp.lastName AS employee_last_name,emp.title,
 mng.firstName AS manager_first_name,mng.lastName AS manager_last_name
FROM employee e
INNER JOIN employee mng
ON emp.managerId = mng.employeeId;

#Find salespeople who have zero sales
SELECT emp.firstName, emp.lastName
FROM  employee emp
LEFT JOIN  sales s ON emp.employeeId = sls.employeeId
WHERE emp.title= 'Sales Person' AND salesAmount ISNULL;

#List all customers and their sales, even if some data is gone
SELECT cus.firstName, cus.lastName, sls.salesAmount
FROM customer cus
INNER JOIN sales sls
    ON cus.customerId = sls.customerId
UNION
-- UNION WITH CUSTOMERS WHO HAVE NO SALES
SELECT cus.firstName, cus.lastName,sls.salesAmount
FROM customer cus
LEFT JOIN sales sls
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION
-- UNION WITH SALES MISSING CUSTOMER DATA
SELECT cus.firstName, cus.lastName, sls.salesAmount
FROM sales sls
LEFT JOIN customer cus
    ON cus.customerId = sls.customerId
WHERE cus.customerId IS NULL;

#another optimized and cleaner way: 
SELECT 
    COALESCE(cus.firstName, 'N/A') AS firstName, 
    COALESCE(cus.lastName, 'N/A') AS lastName, 
    COALESCE(sls.salesAmount, 0) AS salesAmount
FROM customer cus
FULL OUTER JOIN sales sls
    ON cus.customerId = sls.customerId;
