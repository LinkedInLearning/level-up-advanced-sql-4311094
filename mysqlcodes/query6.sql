SELECT s.salesId
from sales s
LEFT JOIN inventory i 
on s.inventoryId = i.inventoryId
  LEFT JOIN model m
  on i.modelId = m.modelId
  WHERE EngineType = 'Electric'
