SELECT 
    emp.firstName, 
    emp.lastName,
    SUM(CASE WHEN strftime('%m', soldDate) = '01' THEN salesAmount ELSE null END) AS JanSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '02' THEN salesAmount ELSE null END) AS FebSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '03' THEN salesAmount ELSE null END) AS MarSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '04' THEN salesAmount ELSE null END) AS AprSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '05' THEN salesAmount ELSE null END) AS MaySales,
    SUM(CASE WHEN strftime('%m', soldDate) = '06' THEN salesAmount ELSE null END) AS JunSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '07' THEN salesAmount ELSE null END) AS JulSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '08' THEN salesAmount ELSE null END) AS AugSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '09' THEN salesAmount ELSE null END) AS SepSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '10' THEN salesAmount ELSE null END) AS OctSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '11' THEN salesAmount ELSE null END) AS NovSales,
    SUM(CASE WHEN strftime('%m', soldDate) = '12' THEN salesAmount ELSE null END) AS DecSales
FROM 
    sales sls
INNER JOIN 
    employee emp ON sls.employeeId = emp.employeeId
WHERE 
    sls.soldDate BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY 
    emp.firstName, 
    emp.lastName
ORDER BY 
    emp.lastName, 
    emp.firstName;
