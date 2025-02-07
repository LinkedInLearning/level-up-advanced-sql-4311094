WITH 
Sales_by_customer AS (
  SELECT
    customerId,
    SUM(salesAmount) AS TotalSales
  FROM sales
  GROUP BY customerId
),
joined AS(
SELECT
  *
FROM customer AS c
FULL OUTER JOIN Sales_by_customer AS s
ON c.customerid = s.customerid
WHERE c.customerId IS NULL OR s.customerId IS NULL

)
SELECT * FROM joined
ORDER BY firstName