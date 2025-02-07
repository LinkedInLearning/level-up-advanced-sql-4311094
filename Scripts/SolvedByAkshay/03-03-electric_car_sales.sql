WITH
electric_models_inventory AS (
  SELECT 
    m.modelId,
    m.model,
    i.inventoryId 
  FROM model AS m
  LEFT JOIN inventory AS i
    ON m.modelId = i.modelId
  WHERE m.EngineType = 'Electric'
),
electric_model_sales AS(
  SELECT
    s.salesId,
    s.customerId,
    s.employeeId,
    s.soldDate,
    s.inventoryId,
    m.model,
    s.salesAmount
  FROM Sales AS s
  INNER JOIN electric_models_inventory AS m
    ON s.inventoryid = m.inventoryId
    
)
SELECT * FROM electric_model_sales
