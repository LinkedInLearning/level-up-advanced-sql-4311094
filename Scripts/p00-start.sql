select e.firstName, e.lastName, e.title, m.firstName as 'Manager First Name', m.lastName as 'Manager Last Name'
from employee e
INNER JOIN employee m
ON e.managerId = m.employeeId;