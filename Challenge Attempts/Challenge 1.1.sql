SELECT 
  e.firstName AS 'First Name', 
  e.lastName AS 'Last Name', 
  e.title AS 'Title',
  m.firstName AS 'Manager First Name',
  m.lastName AS 'Manager Last Name'
  FROM employee e 
  INNER JOIN employee m ON m.employeeID = e.managerId