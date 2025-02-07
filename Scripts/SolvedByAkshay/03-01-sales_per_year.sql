WITH
sales_per_year AS(
  SELECT
    strftime('%Y',soldDate) AS Sale_Year,
    ROUND(SUM(SalesAmount), 2) AS AnnualSales
  FROM Sales
  GROUP BY strftime('%Y',soldDate)
)
SELECT * FROM sales_per_year