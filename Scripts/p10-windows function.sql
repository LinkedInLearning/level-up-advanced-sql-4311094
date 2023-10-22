WITH CTE AS (select strftime('%Y', s.soldDate) AS soldYear, 
  strftime('%m', s.soldDate) AS soldMonth, SUM(s.salesAmount) as totalSales 
  from sales s
  GROUP BY soldYear, soldMonth
  ORDER BY soldYear, soldMonth)

  SELECT soldYear, soldMonth, totalSales, 
  SUM(totalSales) 
  OVER (PARTITION BY soldYear ORDER BY soldYear, soldMonth) 
  as annualSales 
  from CTE
  ;
