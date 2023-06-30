select employee.firstName as FirstName,
        employee.lastName as LastName,
        employee.title as title,
        sales.salesAmount as SalesAmount
 from employee  
 LEFT join  sales
 on sales.employeeId = employee.employeeId where employee.title = 'Sales Person'
       and sales.salesAmount is null or sales.salesAmount =0;