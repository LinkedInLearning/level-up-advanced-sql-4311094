SELECT firstName, lastName, title
FROM employee
LIMIT 5;


GO 

SELECT model, EngineType
FROM model
LIMIT 5;


SQL Table Details

SELECT sql
FROM sqlite_schema
WHERE name = 'employee';