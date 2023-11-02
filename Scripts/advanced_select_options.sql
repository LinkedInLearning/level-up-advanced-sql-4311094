
CREATE TABLE TotalSalesByYear (
  Year int,
  Sales int
);

WITH cte AS (
SELECT strftime('%Y',soldDate) AS soldYear, salesAmount
FROM sales
)
SELECT soldYear,
  FORMAT("$%.2f",sum(salesAmount)) AS AnnualSales
FROM cte 
GROUP BY soldYear
ORDER BY soldYear;

SELECT * FROM sales LIMIT 5;

SELECT
    employeeId,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-01%' THEN salesAmount
        ELSE 0
      END
    ) AS JanuarySales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-02%' THEN salesAmount
        ELSE 0
      END
    ) AS FebruarySales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-03%' THEN salesAmount
        ELSE 0
      END
    ) AS MarchSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-04%' THEN salesAmount
        ELSE 0
      END
    ) AS AprilSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-05%' THEN salesAmount
        ELSE 0
      END
    ) AS MaySales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-06%' THEN salesAmount
        ELSE 0
      END
    ) AS JuneSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-07%' THEN salesAmount
        ELSE 0
      END
    ) AS JulySales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-08%' THEN salesAmount
        ELSE 0
      END
    ) AS AugustSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-09%' THEN salesAmount
        ELSE 0
      END
    ) AS SeptemberSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-10%' THEN salesAmount
        ELSE 0
      END
    ) AS OctoberSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-11%' THEN salesAmount
        ELSE 0
      END
    ) AS NovemberSales,
    SUM(
      CASE
        WHEN soldDate LIKE '2021-12%' THEN salesAmount
        ELSE 0
      END
    ) AS DecemberSales

FROM sales
GROUP BY employeeId;