with cte as 
(select 
  strftime('%Y-%m', solddate) as monthsold,
  count(salesId) as 'numberof_cars'
from sales
GROUP BY monthsold)

select monthsold, numberof_cars as ThisMonth,
  LAG(numberof_cars, 1,0) over calmonth as PreviousMonth
from cte
WINDOW calmonth as (ORDER BY monthsold)
ORDER by monthsold