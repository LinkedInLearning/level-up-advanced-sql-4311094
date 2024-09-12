select * from sales s limit 10;


WITH cte AS (
SELECT s.salesId, s.employeeId, s.soldDate, strftime('%m', s.soldDate) as 'sellingMonth' 
from sales s 
WHERE s.soldDate BETWEEN date('2021-01-01') and date('2021-12-31'))
SELECT c.employeeId, e.firstName, e.lastName, c.sellingMonth, count(c.salesId) as 'totalSales21'
from cte c
INNER JOIN employee e on e.employeeId = c.employeeId
GROUP BY c.employeeId
ORDER by sellingMonth asc, totalSales21 desc
;