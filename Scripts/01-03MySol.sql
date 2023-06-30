select c.firstName as FirstName,
        c.lastName as lastName,
        c.email asEmail,
        s.salesId 
        from customer c 
          inner join sales s 
            on c.customerId = s.customerId
union 
select c.firstName as FirstName,
        c.lastName as lastName,
        c.email asEmail,
        s.salesId 
        from customer c 
          left join sales s 
            on c.customerId = s.customerId where s.salesId is null
UNION
select c.firstName as FirstName,
        c.lastName as lastName,
        c.email asEmail,
        s.salesId 
        from customer c 
          RIGHT join sales s 
            on c.customerId = s.customerId where c.customerId is null;