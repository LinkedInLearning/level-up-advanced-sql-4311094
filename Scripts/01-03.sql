-- List all customers & their sales, even if some data is gone

-- FULL OUTER JOIN NOT SUPPORTED

SELECT *
FROM customer c
INNER JOIN sales s
    ON c.customerId = s.customerId
UNION
-- UNION WITH CUSTOMERS WHO HAVE NO SALES
SELECT *
FROM customer c
LEFT JOIN sales s
    ON c.customerId = s.customerId
WHERE s.salesId IS NULL;