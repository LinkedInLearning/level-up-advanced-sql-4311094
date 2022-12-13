-- Create a report showing sales per month and an annual total

SELECT strftime('%Y', soldDate) AS soldYear, strftime('%m', soldDate) AS soldMonth, salesAmount,
SUM (salesAmount) OVER (
  PARTITION BY strftime('%Y', soldDate)
  ORDER BY strftime('%m', soldDate)
) AS AnnualRunningTotal
FROM sales
GROUP BY soldYear, soldMonth
ORDER BY  soldYear, soldMonth

-- partition over the year so that the running total resets annually
-- group by soldYear, soldMonth to collect the data from the sales table how we need it for the report