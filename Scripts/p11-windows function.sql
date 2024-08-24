select strftime('%Y-%m', s.soldDate) as soldMonth,
  COUNT(s.salesId) as carsSold,
  LAG (count(s.salesId), 1, 0) OVER calMonth as carsSoldLastMonth
  from sales s
  GROUP BY soldMonth
  WINDOW calMonth AS (ORDER BY strftime('%Y-%m', s.soldDate));