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