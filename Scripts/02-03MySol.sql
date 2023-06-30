SELECT e.firstName,e.lastName,e.employeeId , count(*) as NumberOfSale
from employee e 
inner join sales s on e.employeeId = s.employeeId
  where s.soldDate >= date('now', 'start of year')
  group by e.employeeId HAVING count(*)>5;
