select e.employeeId, e.firstName, e.lastName, count(s.salesId) as 'totalSales' 
from sales s
INNER join employee e on e.employeeId = s.employeeId
group by s.employeeId, e.firstName, e.lastName
order by totalSales desc;