-- with ctc as (
SELECT
  emp.employeeid, emp.firstname, emp.lastname, 
  count(sale.employeeid) as "Total_car_sold"
FROM employee as emp
INNER JOIN sales as sale
  on emp.employeeid = sale.employeeid
WHERE sale.soldDate >= date('now','start of year')
GROUP BY
  sale.employeeid
HAVING 
 "Total_car_sold" > 5 ;
--  )


