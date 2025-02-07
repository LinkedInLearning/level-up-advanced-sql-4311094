WITH
Sales_by_salesperson AS (
  SELECT
    s.employeeId,
    e.firstName,
    e.lastName,
    s.inventoryId,
    i.modelId,
    m.model,
    COUNT(s.inventoryId) AS cars_sold
  FROM sales AS s
  LEFT JOIN inventory AS i
    ON s.inventoryId = i.inventoryId
  LEFT JOIN model AS m
    ON i.modelId = m.modelId
  LEFT JOIN employee AS e
    ON s.employeeId = e.employeeId
  GROUP BY e.firstName,
    e.lastName, i.modelId, m.model
),
ranked_sales AS (
  SELECT
    firstName,
    lastName,
    model,
    cars_sold,
    RANK() OVER(PARTITION BY firstName, lastName ORDER BY cars_sold desc) AS Rank
  FROM sales_by_Salesperson

)
SELECT * FROM ranked_sales