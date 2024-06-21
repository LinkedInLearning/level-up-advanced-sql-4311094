SELECT e.employeeId,e.firstName,e.lastName,count(s.employeeId) as CarsSold
FROM employee e
LEFT JOIN sales s 
ON e.employeeId = s.employeeId
GROUP BY e.employeeId,e.firstName,e.lastName
ORDER BY CarsSold DESC