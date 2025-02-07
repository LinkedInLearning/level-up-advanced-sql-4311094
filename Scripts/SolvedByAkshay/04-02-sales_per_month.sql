WITH
sales_per_month AS(
  SELECT
    strftime('%m', soldDate) AS month,
    strftime('%Y', soldDate) AS year,
    SUM(Salesamount) AS monthly_sale
  FROM Sales
  GROUP BY strftime('%Y-%m', soldDate)
)
SELECT 
  month,
  year,
  monthly_sale,
  SUM(monthly_sale) OVER(
    PARTITION BY year 
    ORDER BY month) AS annual_running_total 
FROM sales_per_month
ORDER BY Year,month