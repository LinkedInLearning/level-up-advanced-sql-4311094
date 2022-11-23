-- Display report for employees who have sold at least 10 cars

SELECT e.employeeId, count(*) as NumOfCarsSold, min(salesAmount) as MinSalesAmount, max(salesAmount) as MaxSalesAmount
FROM sales s
INNER JOIN employee e
    on s.employeeId = e.employeeId
GROUP BY e.employeeId
HAVING count(*) > 10

-- note about not being able to reference NumOfCarsSold for having