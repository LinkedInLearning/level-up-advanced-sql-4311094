select 
  emp.firstname, emp.lastname, emp.title, emp.startdate, 
  sale.salesId
FROM 
  employee AS emp
LEFT JOIN sales as sale ON
  emp.employeeId = sale.employeeid
WHERE 
  emp.title = "Sales Person"
  AND 
  sale.salesAmount is NULL;
