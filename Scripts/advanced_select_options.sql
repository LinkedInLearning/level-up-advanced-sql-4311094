
CREATE TABLE TotalSalesByYear (
  Year int,
  Sales int
);

WITH cte AS (
SELECT strftime('%Y',soldDate) AS soldYear, salesAmount
FROM sales
)
SELECT soldYear,
  FORMAT("$%.2f",sum(salesAmount)) AS AnnualSales
FROM cte 
GROUP BY soldYear
ORDER BY soldYear;

SELECT employeeId, salesAmount, soldDate 
CASE
END
FROM sales LIMIT 5;