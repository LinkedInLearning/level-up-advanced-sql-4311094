WITH 
employees_with_managers AS (
  SELECT 
    e.employeeId,
    e.firstName AS EmployeeFirstName,
    e.lastName AS EmployeeLastName,
    e.title AS EmployeeTitle,
    e.startDate AS EmployeeStartDate,
    e.managerId AS EmployeesManagerID,
    m.firstName AS ManagerFirstname,
    m.lastName AS ManagerLastname,
    m.title AS ManagerTitle,
    m.startDate AS ManagerStartDate,
    COALESCE(m.managerId, 'NA') AS ManagersManagerID
  FROM employee AS e
  LEFT JOIN employee AS m
    ON e.managerId = m.employeeId 
)
SELECT * FROM employees_with_managers
ORDER BY employeeId
