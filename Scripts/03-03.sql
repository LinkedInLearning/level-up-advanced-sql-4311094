-- Find sales of cars which are electric by using a subquery

-- 1. join sales and inventory
SELECT *
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId

-- 2. review the model table
Select *
from model
limit 10;

-- 3. lookup the modelId for the electric models
SELECT modelId
FROM model
WHERE EngineType = 'Electric';


-- Final query
SELECT sls.soldDate, sls.salesAmount, inv.colour, inv.year
FROM sales sls
INNER JOIN inventory inv
  ON sls.inventoryId = inv.inventoryId
WHERE inv.modelId IN (
  SELECT modelId
  FROM model
  WHERE EngineType = 'Electric'
)
