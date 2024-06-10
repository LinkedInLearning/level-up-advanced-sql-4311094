
SELECT
  emp.employeeid, emp.firstname, emp.lastname, count(sale.employeeid) as "Total_car_sold"
FROM employee as emp
INNER JOIN sales as sale
  on emp.employeeid = sale.employeeid
GROUP BY
  sale.employeeid
ORDER BY "Total_car_sold" DESC ;
