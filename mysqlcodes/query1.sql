SELECT e1.firstName ,e1.lastName , e2.firstName as Manager_Name
 
FROM employee e1
LEFT JOIN employee as e2
on e1.managerId = e2.employeeId;