-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100
SELECT
Amount, Customers, Boxes
FROM
sales
WHERE
Amount > 2000 and Boxes < 100
order by Amount;

-- How many shipments (sales) each of the sales persons had in the month of January 2022?
select 
Salesperson, COUNT(*) AS 'total'
from people
join sales
on people.SPID = sales.SPID
where 
year (SaleDate) = 2022 and month(SaleDate) = 1
group by
Salesperson
order by
total desc;

-- Which product sells more boxes? Milk Bars or Eclairs?
select Product, Category,  sum(Boxes) as 'boxes'
from products
join sales
on sales.PID = products.PID
where Product in ('Milk Bars', 'Eclairs')
group by
Product, Category
Order by 
boxes desc;

-- Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs
select Product,  sum(Boxes) as 'boxes'
from products
join sales
on sales.PID = products.PID
where
SaleDate between '2022/02/01' and '2022/02/07' and Product in ('Milk Bars', 'Eclairs')
group by
Product
Order by 
boxes desc;

-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select product, Customers, Boxes
from products
join sales
on sales.PID = products.PID
where
Customers < 100 and boxes < 100 and day(SaleDate) = 4;


-- India or Australia? Who buys more chocolate boxes on a monthly basis?
select GEO,SUM(Boxes) as 'boxes'
from geo
join sales
on geo.GeoID = sales.GeoID
join products
on Sales.PID = products.PID
WHERE GEO IN ('India', 'Australia')
Group by
geo
order by
boxes desc;

-- Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select geo, product, Category, size, count(*) as 'total', month(SaleDate) as 'Month'
from geo
join sales
on geo.GeoID = sales.GeoID
join products
on Sales.PID = products.PID
WHERE GEO = 'New Zealand' and Product = 'After Nines'
group by
geo, product, Category, size, SaleDate;


-- How many times we shipped more than 1,000 boxes in each month
select Month(SaleDate) as 'Month', sum(boxes) as 'boxes', count(*) as 'total'
from products
join sales
on sales.PID = products.PID
where boxes > 1000
group by
SaleDate
order by 
'month';


-- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select
saledate, salesperson, SUM(boxes), SUM(customers), SUM(amount)
from
sales
join
people
on sales.SPID = people.SPID
where
SaleDate between '2022/01/01' and '2022/01/07'
GROUP BY
SaleDate, Salesperson
Order by
SaleDate;

-- Which salespersons did not make any shipments in the first 7 days of January 2022
select distinct salesperson, boxes
from sales
join people
on sales.spid = people.spid
where
SaleDate between '2022/01/01' and '2022/01/07';

-- Which salespersons did not make any shipments in the first 7 days of January 2022
select distinct salesperson
from people p
where p.SPID not in
	(Select distinct s.spid from sales s where s.saledate between '2022/01/01' and '2022/01/07');