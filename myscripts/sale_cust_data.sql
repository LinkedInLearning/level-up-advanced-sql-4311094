(SELECT 
  c.customerid, c.firstname, c.lastname, c.city, s.salesid, s.salesamount
FROM customer as C
inner join sales as s 
  on c.customerid = s.customerid
)
UNION
(SELECT 
  c.customerid, c.firstname, c.lastname, c.city, s.salesid, s.salesamount
FROM customer as C
LEFT join sales as s 
  on c.customerid = s.customerid
WHERE
  s.salesid is NULL
)
UNION
(SELECT 
  c.customerid, c.firstname, c.lastname, c.city, s.salesid, s.salesamount
FROM customer as C
RIGHT join sales as s 
  on c.customerid = s.customerid
WHERE 
  c.customerid is NULL
)