-- Displays the number of cars sold this month, and last month

-- Get the data
SELECT strftime('%Y-%m', soldDate) AS MonthSold,
  count(*) AS NumberCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)

-- Apply the window function
SELECT strftime('%Y-%m', soldDate) AS MonthSold,
  count(*) AS NumberCarsSold,
  LAG (count(*), 1, 0 ) OVER calMonth AS LastMonthCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)
WINDOW calMonth AS (ORDER BY strftime('%Y-%m', soldDate))
ORDER BY strftime('%Y-%m', soldDate)

-- LAG to get last months
-- this time defining the window seperatly and then refering to that window in the select statement
  -- this allows more flexibility as you to use the same window multiple times
  -- or you can use window chaining where one window can build on top of another

