-- 1. list employess and their immediate managers
select e.firstName, e.lastName, e.title, m.firstName managerFirstName, m.lastName managerLastName
from employee e
join employee m
  on e.managerId = m.employeeId;

-- 2. list sales people with zero sales
select *
from sales
where salesAmount is NULL; /* there are no people without sales, in the sales table*/

-- bad query:
/* before the WHERE clasue, it will return all records from employee
because we are forcing the match between e.employeeId and (s.employeeId and salesAmount is NULL)
which as we stated above, there are no people with salesAmount = NULL;
Thus, the left join will return all rows from the employee table (even if there's no match) with all 
values = NULL (this is what left join does; if no match return anyways but with NULLs)
Next, comes the WHERE clause which will reduce the output to only 'Sales Person' (39 records)
*/
select e.firstName, e.lastName, s.salesAmount
-- select count(*)
from employee e
left join sales s
  on e.employeeId = s.employeeId and s.salesAmount IS NULL
where e.title = 'Sales Person';

-- good query
/* Here we first (left) join, thus again all records from employee,
but next we filter for Sales Person and salesAmount is NULL (remember that left join returns all rows
filled with NULLs where there's no match)
*/
select e.firstName, e.lastName, s.salesAmount
from employee e
left join sales s
  on e.employeeId = s.employeeId 
where e.title = 'Sales Person' and s.salesAmount IS NULL;

-- 3. list all sales and customers, even if data has been removed
/* course states that full outer join is not working properly in sqllite
the official solution is with union (inner join union left join where customer data is null union
left joing where sales data is null)
*/
select c.*, s.*
from customer c
full join sales s
  on c.customerId = s.customerId
  order by firstName;

-- 4. How many cars have been sold per employee
select e.employeeId, e.firstName, e.lastName, count(*) as NumOfCars
from employee e
JOIN sales s
  on e.employeeId = s.employeeId
group by e.employeeId, e.firstName, e.lastName
order by e.firstName;


-- 5. List the least and most expensive car sold by each employee this year
select employeeId, "Least expensive", min(salesAmount) Amount
from sales
where strftime('%Y', soldDate) = '2023'
UNION
select employeeId, "Most expensive", max(salesAmount)
from sales
where strftime('%Y', soldDate) = '2023';

select employeeId, min(salesAmount), max(salesAmount)
from sales
where strftime('%Y', soldDate) = '2023';

select employeeId, min(salesAmount), max(salesAmount)
from sales
where soldDate >= date('now', 'start of year');

-- 6. list of employess who have made 5+ sales
select employeeId, count(*) NoCarsSold
from sales
where soldDate >= date('now', 'start of year')
group by employeeId
having count(*) >5;


-- 7. Total sales per year
select strftime('%Y', soldDate) Year, round(sum(salesAmount),2) TotalSales
from sales
group by 1;

with years as (
  select strftime('%Y', soldDate) Year, salesAmount
  from sales)
select year, FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales
from years
group by Year;

-- 8. Amount of sales per employee for each month in 2021

with months_21 as (
  select strftime('%m', soldDate) Month, employeeId, salesAmount
  from sales
  where strftime('%Y', soldDate) = '2021')
select employeeId, Month, sum(salesAmount) MonthlySales
from months_21
group by employeeId
order by 1, 2, 3;

/* solution says that the output should act like a matrix 
with employees as rows, months as columns and values as monthly sales
*/
CREATE TABLE months_lookup (Month TEXT);
INSERT INTO months_lookup VALUES 
('01'), ('02'), ('03'), ('04'), ('05'), ('06'), ('07'), ('08'), ('09'), ('10'), ('11'), ('12');
SELECT * FROM months_lookup;

WITH months_21_sales AS (
  SELECT strftime('%m', soldDate) AS Month, employeeId, SUM(salesAmount) AS MonthlySales
  FROM sales
  WHERE strftime('%Y', soldDate) = '2021'
  GROUP BY strftime('%m', soldDate), employeeId
),
data_with_nulls AS (
    SELECT e.employeeId, m.Month, 
           coalesce(s.MonthlySales, 0) AS MonthlySales
    FROM (SELECT DISTINCT employeeId FROM sales) e
    CROSS JOIN months_lookup m
    LEFT JOIN months_21_sales s ON e.employeeId = s.employeeId AND m.Month = s.Month
)
SELECT employeeId, 
       group_concat(MonthlySales) AS MonthlySalesString
FROM (
    SELECT employeeId, MonthlySales
    FROM data_with_nulls
    ORDER BY employeeId, Month
  )
GROUP BY employeeId;

SELECT * 
FROM crosstab(
  'YOUR SECOND QUERY HERE', 
  'SELECT * FROM months_lookup ORDER BY Month'
) AS final_result (employeeId INT, Jan NUMERIC, Feb NUMERIC, Mar NUMERIC, Apr NUMERIC, May NUMERIC, Jun NUMERIC, Jul NUMERIC, Aug NUMERIC, Sep NUMERIC, Oct NUMERIC, Nov NUMERIC, Dec NUMERIC);
