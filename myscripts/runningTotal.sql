with cte as 
(SELECT
  strftime('%m',solddate) as month,
  strftime('%Y',solddate) as year,
  sum(salesamount) as 'monthsale'
from sales
GROUP BY year, month
ORDER BY soldDate)

select year, month, format('$%.2f',monthsale) as 'monthsale', 
   sum(monthsale) over (PARTITION BY year order by month ) as 'annual_total'
from cte
order by year, month;