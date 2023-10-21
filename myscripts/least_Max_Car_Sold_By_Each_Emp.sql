
SELECT
  emp.employeeid, emp.firstname, emp.lastname, 
  min(sale.salesamount) as "min_sold",
  max(sale.salesamount) as "max_sold",
  sale.soldDate
FROM employee as emp
INNER JOIN sales as sale
  on emp.employeeid = sale.employeeid
WHERE
  sale.soldDate >= date('now', 'start of year')
GROUP BY
  sale.employeeid
ORDER BY emp.employeeId  ;
