select firstname, lastname, title 
from employee
LIMIT 5;

select model, EngineType
from model
limit 5;

select sql
from sqlite_schema
where name = 'employee';

-- Create a list of employees and their immediate manager...
SELECT emp.firstName, emp.lastName, emp.title,
--emp.employeeId, 
mng.firstName AS Manager_FirstName, mng.lastName as Manager_LastName
--mng.employeeId
from employee emp
INNER JOIN employee mng
on emp.managerId=mng.employeeId;

select sql
from sqlite_schema
where name = 'sales';

select title, count(employeeId) as count from employee GROUP by title;

-- Find sales people who have zero sales
SELECT emp.firstName, emp.lastName, emp.title, emp.startDate, sls.salesId
from employee emp
LEFT JOIN sales sls 
on emp.employeeId=sls.employeeId
WHERE emp.title = 'Sales Person' AND sls.salesId IS NOT NULL; -- IS NOT NULL

select sql
from sqlite_schema
where name = 'customer'; -- sales, 

-- List all customers & their sales, even if some data is gone

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
INNER JOIN sales sls
    ON cus.customerId = sls.customerId 
UNION
-- UNION WITH CUSTOMERS WHO HAVE NO SALES
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
LEFT JOIN sales sls
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION
-- UNION WITH SALES MISSING CUSTOMER DATA
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls
LEFT JOIN customer cus
    ON cus.customerId = sls.customerId
WHERE cus.customerId IS NULL;

---- How many cars has been sold per employee
SELECT emp.employeeId, emp.firstName, emp.lastName 
from sales sls
INNER JOIN employee emp
on sls.employeeId = emp.employeeId

-- then add the group by & count
SELECT emp.employeeId, emp.firstName, emp.lastName, count(*) as no_of_cars_sold 
from sales sls
INNER JOIN employee emp
on sls.employeeId = emp.employeeId
group by emp.employeeId, emp.firstName, emp.lastName
order by no_of_cars_sold DESC; -- LIMIT 25

-- Find the least and most expensive car sold by each employee this year
SELECT emp.employeeId, emp.firstName, emp.lastName, 
MIN(salesAmount)AS MinSalesAmount, MAX(salesAmount) AS MaxSalesAmount
from sales sls 
INNER JOIN employee emp
ON sls.employeeId=emp.employeeId
WHERE sls.soldDate >= Date ('Now', 'start of year')
GROUP BY emp.employeeId, emp.firstName, emp.lastName; 

-- Display report for employees who have sold at least 5 cars
SELECT emp.employeeId, emp.firstName, emp.lastName, 
count(*) as NumOfCarsSold,
MIN(salesAmount)AS MinSalesAmount, MAX(salesAmount) AS MaxSalesAmount
from sales sls 
INNER JOIN employee emp
ON sls.employeeId=emp.employeeId
WHERE sls.soldDate >= Date ('Now', 'start of year')
GROUP BY emp.employeeId, emp.firstName, emp.lastName
HAVING count (*) >10;

-- Summarise sales per year by using a CTE
WITH cte as (
SELECT strftime('%Y', soldDate) AS soldYear,
salesAmount from sales
)
SELECT soldYear, FORMAT("$%.2f", sum(salesAmount)) as AnnualSales
from cte GROUP BY soldYear ORDER BY soldyear;