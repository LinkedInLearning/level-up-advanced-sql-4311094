SELECT e.employeeId,strftime('%m',s.soldDate),sum(s.salesAmount)
from sales s
LEFT JOIN employee e ON e.employeeId = s.employeeId
WHERE s.soldDate >= '2021-01-01'
AND s.soldDate < '2022-01-01'
GROUP BY e.employeeId,strftime('%m',s.soldDate)
ORDER BY e.employeeId,strftime('%m',s.soldDate) 