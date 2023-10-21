select 
  s.salesid, i.modelId, s.soldDate, s.salesAmount
from sales as s
inner join 
  inventory as i on i.inventoryId = s.inventoryId
WHERE
  i.modelId in 
  (select modelid from model
where enginetype = 'Electric');