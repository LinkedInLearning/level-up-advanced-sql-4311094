Select sum(salesAmount),strftime('%Y', soldDate) AS soldYear   from sales
  group by strftime('%Y', soldDate) ;
