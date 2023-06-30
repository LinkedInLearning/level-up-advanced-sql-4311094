select e.firstName as firstName,
        e.lastName, count(s.salesId)
         from employee e inner JOIN
         sales s on e.employeeId = s.employeeId
         GROUP by e.employeeId
         ;