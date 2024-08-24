select e.employeeId, e.firstName, e.lastName, count(s.salesId) as 'totalSales'
from employee e
INNER JOIN sales s ON e.employeeId = s.salesId
GROUP by s.employeeId 
having totalSales >= 5
order by totalSales desc;