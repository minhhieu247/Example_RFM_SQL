-- Lọc data
with sumary as
(
	select CustomerID, OrderDate, sum(OrderTotal) as sumtotal
	from Orders
	group by  CustomerID, OrderDate
	
)
-- calculate RFM(recency_frequence_Monetary Value)
select CustomerID,
datediff(day,max(OrderDate),GETDATE()),
count(*),
sum(sumtotal) ,
ntile(6) over(order by datediff(day,max(OrderDate),GETDATE()) ) as R ,
ntile (6) over (order by count(*)) as F,
ntile(6) over (order by sum(sumtotal) ) as M
from sumary
group by CustomerID