-- How many cars has been sold per employee

SELECT e.employeeId, e.firstName, e.lastName, count(*) as NumOfCarsSold
FROM sales s
INNER JOIN employee e
    on s.employeeId = e.employeeId
GROUP BY e.employeeId, e.firstName, e.lastName;
