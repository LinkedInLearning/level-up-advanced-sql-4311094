select * from customer;
select * from sales limit 10;

SELECT c.firstName, c.lastName, c.email, s.salesAmount, s.soldDate
FROM customer c
INNER JOIN sales s ON s.customerId = c.customerId
UNION
SELECT c.firstName, c.lastName, c.email, s.salesAmount, s.soldDate
FROM customer c
LEFT JOIN sales s ON s.customerId = c.customerId
WHERE s.salesId is null
UNION
SELECT c.firstName, c.lastName, c.email, s.salesAmount, s.soldDate
FROM sales s
LEFT JOIN customer c ON s.customerId = c.customerId
WHERE c.customerId is null;
