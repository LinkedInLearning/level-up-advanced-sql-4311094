
  select s.employeeId, e.firstName, e.lastName, MAX(s.salesAmount) as 'saleAmount'
  from sales s
  inner join employee e on e.employeeId = s.employeeId
  group by s.employeeId
  UNION
  select s.employeeId, e.firstName, e.lastName, MIN(s.salesAmount) as 'saleAmount'
  from sales s
  inner join employee e on e.employeeId = s.employeeId
  group by s.employeeId
  order by saleAmount desc;

  select s.employeeId, e.firstName, e.lastName,
  MAX(s.salesAmount) as 'highestSale', MIN(s.salesAmount) as 'lowestAmount'
  from sales s
  inner join employee e on e.employeeId = s.employeeId
  where s.soldDate >= date('now', 'start of year')
  group by s.employeeId;