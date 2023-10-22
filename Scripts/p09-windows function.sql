select e.firstName, e.lastName, e.title, s.salesAmount, m.model, 
  count(m.model) AS 'totalSold', 
  rank() OVER (PARTITION BY s.employeeId ORDER BY count(m.model) DESC) AS rank
  from employee e
  INNER JOIN sales s ON s.employeeId = e.employeeId
  INNER JOIN inventory i ON i.inventoryId = s.inventoryId
  INNER JOIN model m ON m.modelId = i.modelId
  GROUP BY e.firstName, e.lastName, m.model;