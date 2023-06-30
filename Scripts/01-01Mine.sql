select e.firstName as EmployeeFirstName,
        e.lastName as EmployeeLastName ,
        m.firstName as ManagerFirstName,
        m.lastName as ManagerLastName from employee e, employee m where e.managerId = m.employeeId;
