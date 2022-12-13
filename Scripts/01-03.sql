-- List all customers & their sales, even if some data is gone

-- FULL OUTER JOIN NOT SUPPORTED

SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
INNER JOIN sales sls
    ON cus.customerId = sls.customerId
UNION
-- UNION WITH CUSTOMERS WHO HAVE NO SALES
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM customer cus
LEFT JOIN sales sls
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION
-- UNION WITH SALES MISSING CUSTOMER DATA
SELECT cus.firstName, cus.lastName, cus.email, sls.salesAmount, sls.soldDate
FROM sales sls
LEFT JOIN customer cus
    ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL;

-- Both UNION and UNION ALL operators combine
rows from result sets into a single result set.
The UNION operator removes eliminate duplicate rows,
whereas the UNION ALL operator does not.

-- Because the UNION ALL operator does not remove duplicate rows,
--it runs faster than the UNION operator.