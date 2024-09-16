SELECT E.firstName, E.lastName, M.firstName, M.lastName 
FROM employee E
JOIN employee M
ON E.managerId = M.employeeId;