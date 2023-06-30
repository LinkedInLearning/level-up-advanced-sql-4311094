select e.firstName,e.lastName,
 max(s.salesAmount), s.inventoryId from employee e 
      inner join sales s on 
        e.employeeId=s.employeeId 
        where s.salesAmount is not null
        and s.soldDate >= date('now', 'start of year')
        GROUP by e.employeeId
union 
select e.firstName,e.lastName,
 min(s.salesAmount), s.inventoryId from employee e 
      inner join sales s on 
        e.employeeId=s.employeeId 
        where s.salesAmount is not null
        and s.soldDate >= date('now', 'start of year')
        GROUP by e.employeeId;