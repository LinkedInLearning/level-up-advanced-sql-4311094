-- 1. ----------
-- Create a list of employees and their immediate managers

SELECT emp.firstName,
    emp.lastName,
    emp.title,
    mng.firstName AS ManagerFirstName,
    mng.lastName AS ManagerLastName
FROM employee emp
INNER JOIN employee mng
    ON emp.managerID = mng.employeeID


-- 2. ----------
-- Find sales people with 0 Sales

SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, sls.salesId
FROM employee emp
LEFT JOIN sales sls 
    ON emp.employeeId = sls.employeeId
WHERE emp.title = 'Sales Person'
AND sls.salesID IS NULL;


-- 3. ----------
-- List all customers & their sales, even if some data is gone

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
INNER JOIN sales sls 
    ON cus.customerID = sls.customerId
UNION

-- UNION with customers with NO SALES

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus 
LEFT JOIN sales sls 
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION

-- UNION with sales MISSING customer data

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls 
LEFT JOIN customer cus 
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL;


-- 4. ----------
-- How many cars have been sold PER employee

-- Start with
SELECT emp.employeeId, emp.firstName, emp.lastName
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId

-- Add Groupby & Count
SELECT emp.employeeId, emp.firstName, emp.lastName, count(*) as NumOfCarsSold
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId, emp.firstName, emp.lastName
ORDER BY NumOfCarsSold DESC;


-- 5. ----------
-- Find Least & Most expensive car sold by EACH employee this year

SELECT emp.employeeId,
    emp.firstName,
    emp.lastName,
    MIN(salesAmount) AS MinSalesAmount,
    MAX(salesAmount) AS MaxSalesAmount
FROM sales sls 
INNER JOIN employee emp 
    ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now', 'start of year')
GROUP BY emp.employeeId, emp.firstName, emp.lastName