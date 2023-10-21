SELECT  
  e.firstname, e.lastname, m.model,
  count(m.model) as 'numberSold',
  rank() OVER (PARTITION by s.employeeId 
     order by count(m.model) desc ) as rank
from sales as s 
inner join employee as e
  on s.employeeid = e.employeeid
inner join inventory as i 
  on i.inventoryid = s.inventoryid
inner join model as m 
  on m.modelid = i.modelid
GROUP BY
  s.employeeId, m.modelId
ORDER by 
  s.employeeId;
