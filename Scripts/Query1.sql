#How many cars have been sold per employee?
SELECT emp.employeeId ,emp.firstName,emp.lastName, COUNT(sls.salesAmount) totalSale
FROM sales sls
JOIN employee emp ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId 
ORDER BY 4 DESC ;
#Find the least and most expensive car sold by each employee
SELECT emp.employeeId ,emp.firstName,emp.lastName, MIN(sls.salesAmount) minSale, MAX(sls.salesAmount) maxSale
FROM sales sls
JOIN employee emp ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId ;

#Display a report for employees who have sold more than five cars
SELECT emp.employeeId empId, emp.firstName empFirstName, emp.lastName empLastName, COUNT(sls.salesAmount) sales_count
FROM employee emp
JOIN sales sls ON emp.employeeId=sls.employeeId
GROUP BY 1,2,3
HAVING COUNT(sls.salesAmount)> 5
ORDER BY 4 DESC;



