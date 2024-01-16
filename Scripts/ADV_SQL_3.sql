-- ADV SQL QRYs -- pt3. Subqueries

-- 9. ----------
-- Find sales of ELECTRIC cars using Subquery


-- i) Join sales & inventory

SELECT *
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId


-- ii) Review model table

SELECT *
FROM model
LIMIT 10;


-- iii) Lookup modelId for ELECTRIC models

SELECT modelId
FROM model
WHERE EngineType = 'Electric';


-- iv) Final query

SELECT sls.soldDate, sls.salesAmount, inv.colour, inv.year
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId
WHERE inv.modelId IN (
  SELECT modelId
  FROM model
  WHERE EngineType = 'Electric'
)



-- 10. ----------
-- For EACH sales person, rank MOST SOLD car models


-- i) Join tables
SELECT emp.firstName, emp.lastName, mdl.model, sls.salesId
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model model
  ON mdl.modelId = inv.modelId


-- ii) Apply grouping
SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model model
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model