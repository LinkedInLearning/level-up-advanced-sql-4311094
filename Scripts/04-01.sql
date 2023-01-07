-- For each sales person rank the car models they've sold most

-- First join the tables to get the necessary data
SELECT emp.firstName, emp.lastName, mdl.model, sls.salesId
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model mdl
  ON mdl.modelId = inv.modelId

-- apply the grouping
SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model mdl
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model

-- add in the windowing function
SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold,
  rank() OVER (PARTITION BY sls.employeeId 
              ORDER BY count(model) desc) AS Rank
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model mdl
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model
