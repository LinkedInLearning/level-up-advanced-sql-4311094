-- For each sales person rank the car models they've sold most


SELECT emp.firstName, emp.lastName, mdl.model,
  count(model) AS NumberSold,
  rank() OVER (PARTITION BY sls.employeeId ORDER BY count(model) desc) AS Rank
FROM sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
INNER JOIN inventory inv
  ON inv.inventoryId = sls.inventoryId
INNER JOIN model mdl
  ON mdl.modelId = inv.modelId
GROUP BY emp.firstName, emp.lastName, mdl.model


/*

https://www.sqlite.org/windowfunctions.html
Window functions are distinguished from other SQL functions by the presence of an OVER clause. If a function has an OVER clause, then it is a window function. If it lacks an OVER clause, then it is an ordinary aggregate or scalar function. Window functions might also have a FILTER clause in between the function and the OVER clause.

A window frame is used to specify how many rows around the current row the window should include.

The RANK() function is a window function that assigns a rank to each row in a query’s result set. The rank of a row is calculated by one plus the number of ranks that comes before it.

In this syntax:

First, the PARTITION BY clause divides the rows of the result set into partitions.
Second, the ORDER BY clause specifies the orders of the rows in each a partition.
Third, the RANK() function is applied to each row in each partition and re-initialized when crossing the partition boundary.

The same column values will receive the same ranks.
When multiple rows have the same rank, the rank of the next row is not consecutive

- could use DENSE_RANK if you didn't want gaps in rank
*/