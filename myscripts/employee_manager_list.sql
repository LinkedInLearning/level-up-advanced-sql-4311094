SELECT 
  e.firstName, 
  e.lastName,
  m.firstName, 
  m.lastName
FROM 
  employee AS e 
INNER JOIN employee AS m 
  on e.employeeId = m.managerId
LIMIT 5; 
