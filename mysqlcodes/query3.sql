SELECT e.employeeId,e.firstName,e.lastName,count(s.salesId) as car_count,
max(s.salesAmount) AS max,min(s.salesAmount) as min
FROM employee e
LEFT JOIN sales s
ON e.employeeId = s.employeeId
GROUP BY e.employeeId,e.firstName,e.lastName
HAVING count(s.salesId) > 5
ORDER by car_count DESC
