SELECT strftime('%Y',soldDate),sum(salesAmount)
from sales
GROUP BY strftime('%Y',soldDate)