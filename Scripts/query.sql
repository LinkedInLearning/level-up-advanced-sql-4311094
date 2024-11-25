SELECT emp.firstName,
  emp.lastName,
  emp.title,
  emp.firstName AS ManagerFirstName,
  emp.lastName AS ManagerLastName
FROM employee emp
INNER JOIN employee mng
  ON emp.managerId = mng.employeeId