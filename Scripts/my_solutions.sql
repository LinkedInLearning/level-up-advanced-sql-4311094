-- 1. list employess and their immediate managers
select e.firstName, e.lastName, e.title, m.firstName managerFirstName, m.lastName managerLastName, m.title
from employee e
join employee m
  on e.managerId = m.employeeId;

-- 2. list sales people with zero sales
/* check first if we have missing values for salesAmount*/
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
/* not the proper solution, was just playing with union*/
select employeeId, "Least expensive", min(salesAmount) Amount
from sales
where strftime('%Y', soldDate) = '2023'
UNION
select employeeId, "Most expensive", max(salesAmount)
from sales
where strftime('%Y', soldDate) = '2023';

/* the actual solution*/
select employeeId, min(salesAmount), max(salesAmount)
from sales
where strftime('%Y', soldDate) = '2023';

/*alternative to express the date*/
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

/* using CTE, and FORMAT function*/
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
  where strftime('%Y', soldDate) = '2021'
  )
select employeeId, Month, sum(salesAmount) MonthlySales
from months_21
group by employeeId
order by 1, 2, 3;

/* the excerise asks that the output should be matrix 
with employees as rows, months as columns and values as monthly sales,
even if at some intersections we will have NULLs
*/
CREATE TABLE months_lookup (Month TEXT);
INSERT INTO months_lookup VALUES 
('01'), ('02'), ('03'), ('04'), ('05'), ('06'), ('07'), ('08'), ('09'), ('10'), ('11'), ('12');

SELECT * FROM months_lookup;

WITH months_21 AS (
    SELECT strftime('%m', soldDate) AS Month, employeeId, SUM(salesAmount) AS MonthlySales
    FROM sales
    WHERE strftime('%Y', soldDate) = '2021'
    GROUP BY employeeId, strftime('%m', soldDate)
)
SELECT 
    employeeId, 
    COALESCE(MAX(CASE WHEN Month = '01' THEN MonthlySales END), 0) AS Jan,
    COALESCE(MAX(CASE WHEN Month = '02' THEN MonthlySales END), 0) AS Feb,
    COALESCE(MAX(CASE WHEN Month = '03' THEN MonthlySales END), 0) AS Mar,
    COALESCE(MAX(CASE WHEN Month = '04' THEN MonthlySales END), 0) AS Apr,
    COALESCE(MAX(CASE WHEN Month = '05' THEN MonthlySales END), 0) AS May,
    COALESCE(MAX(CASE WHEN Month = '06' THEN MonthlySales END), 0) AS Jun,
    COALESCE(MAX(CASE WHEN Month = '07' THEN MonthlySales END), 0) AS Jul,
    COALESCE(MAX(CASE WHEN Month = '08' THEN MonthlySales END), 0) AS Aug,
    COALESCE(MAX(CASE WHEN Month = '09' THEN MonthlySales END), 0) AS Sep,
    COALESCE(MAX(CASE WHEN Month = '10' THEN MonthlySales END), 0) AS Oct,
    COALESCE(MAX(CASE WHEN Month = '11' THEN MonthlySales END), 0) AS Nov,
    COALESCE(MAX(CASE WHEN Month = '12' THEN MonthlySales END), 0) AS Dec
FROM months_21
GROUP BY employeeId
ORDER BY employeeId;


-- 9. List all sales where car was electric
select * from model m
join inventory i on i.modelId = m.modelId
join sales s on s.inventoryId = i.inventoryId
WHERE EngineType = 'Electric' ;

/*exercise asks to use a subquery*/
select s.soldDate, s.salesAmount, i.colour, i.year
from sales s
join inventory i on s.inventoryId = i.inventoryId
where i.modelId in (select m.modelId from model m
      where EngineType = 'Electric');



-- 10. List people's sales and rank the car models they've sold most of
select * from model;
select * from sales;
select * from inventory;

select employeeId
      , model
      , count(model) NumberSold
      , rank() over (PARTITION by employeeId order by count(model) desc) rnk
from sales s
join inventory i on i.inventoryId = s.inventoryId
join model m on m.modelId = i.modelId
group by employeeId, model;


-- 11. Sales Report for total sales per month and an annual running total
select * from sales;

WITH MonthlySales AS (
    SELECT strftime('%Y', soldDate) AS Year
          , strftime('%m', soldDate) AS Month 
          , SUM(salesAmount) AS MonthlySalesAmount
    FROM sales
    GROUP BY Year, Month
)
SELECT Year
      , Month
      , format("$%.2f", MonthlySalesAmount) AS MonthlySales
      , format("$%.2f", SUM(MonthlySalesAmount) OVER (PARTITION BY Year ORDER BY Year, Month)) AS YearlyRunningTotal
FROM MonthlySales
ORDER BY Year, Month;

-- 12. A report showing number of cards sold this month and last month
/* i wanted to use self-join for this, to rember the trick for the ON clause*/
SELECT 
     strftime('%Y-%m', sc.soldDate) AS current_month
    ,COUNT(DISTINCT sc.salesId) AS current_month_count
    ,COUNT(DISTINCT sp.salesId) AS previous_month_count
FROM sales sc
LEFT JOIN sales sp ON strftime('%Y-%m', sc.soldDate) = strftime('%Y-%m', date(sp.soldDate, '+1 month'))
GROUP BY current_month;

/*solving with window functions, as per the exercise*/
/* Understanding LAG & LEAD to get the previous month's, 
current's month and next month's sales*/
SELECT strftime('%m', soldDate) Month
      , sum(salesAmount) currnet_month_sales
      , LAG(sum(salesAmount)) OVER (ORDER BY strftime('%m', soldDate)) as previous_month_sales
      , LEAD(sum(salesAmount)) OVER (ORDER BY strftime('%m', soldDate)) AS next_month_sales
FROM sales
GROUP by Month;


SELECT 
    strftime('%Y-%m', soldDate) AS current_month,
    COUNT(DISTINCT salesId) AS current_month_count,
    LAG(COUNT(*), 1, 0) OVER (ORDER BY strftime('%Y-%m', soldDate)) AS previous_month_count
FROM sales
GROUP BY current_month
ORDER BY current_month;








