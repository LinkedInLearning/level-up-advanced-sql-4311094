with ctc as 
(SELECT 
  strftime('%Y', solddate) as 'soldyear',
  salesAmount
from sales
)
select soldyear, format('$%.2f',round(sum(salesAmount),5)) as 'total_sale' 
FROM ctc
GROUP BY soldYear
ORDER BY soldYear;

-- FORMAT("$%.2f", sum(salesAmount)) AS AnnualSales