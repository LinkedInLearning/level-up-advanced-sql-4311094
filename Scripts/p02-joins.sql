select * from sales limit 10;

select e.firstName, e.lastName, count(s.salesId) as 'totalSales'
from employee e
LEFT JOIN sales s ON s.employeeId = e.employeeId
where e.title = 'Sales Person'
group BY e.employeeId
having totalSales = 0
order by totalSales DESC;