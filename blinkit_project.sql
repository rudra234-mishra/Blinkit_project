select*from blinkit_dataset
sp_help blinkit_dataset
-----Data Cleaning Part
select distinct [Item Fat Content]
from blinkit_dataset
update blinkit_dataset
set [Item Fat Content]='Low Fat'
where [Item Fat Content]='lf'
-------
update blinkit_dataset
set [Item Fat Content]='Regular'
where [Item Fat Content]='reg'
----Or
update blinkit_dataset
set [Item Fat Content]=case
                      when [Item Fat Content] in('lf','Low fat') then 'Low Fat'
					  when [Item Fat Content]='reg' then 'Regular'
					  else
					  [Item Fat Content]
					  end
-----Total sales
select round(sum(sales),2) as total_sale
from blinkit_dataset
-----Average Sales
select round(avg(sales),2) as avg_sale
from blinkit_dataset
------or
select cast(avg(sales) as decimal(10,2)) as avg_sale 
from blinkit_dataset
------Number of Items
select count([Item Identifier])as items
from blinkit_dataset
-----Average Rating
select cast(avg(Rating)as decimal(10,0)) avg_rating
from blinkit_dataset
-----Total Sales,Average Sales,Number of item and Average Rating By Fatcontent
select [Item Fat Content],round(sum(sales),2) as total_sales,
                         cast(avg(sales) as decimal(10,2)) as avg_sales,
                         count(*) as total_item,
                         round(avg(rating),2) as avg_rating
from blinkit_dataset
group by [Item Fat Content]
-----Total Sales,Average Sales,Number of item and Average Rating By item type
select [Item Type],round(sum(sales),2) as total_sale,
                  round(avg(sales),2) as avg_sale,
				  count(*) as total_item,
				  cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_dataset
group by [Item Type]
order by total_sale desc
------Fat content by outlet for Total sales
select [Outlet Location Type],[Item Fat Content],
        round(sum(sales),2) as total_sale,
        round(avg(sales),2) as avg_sale,
	    count(*) as total_item,
		cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_dataset
group by [Outlet Location Type],[Item Fat Content]
-----Total Sales By OutletEstablishment
select [Outlet Establishment Year],cast(sum(sales) as decimal(10,2)) as total_sale,
        round(avg(sales),2) as avg_sale,
	    count(*) as total_item,
		cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_dataset
group by [Outlet Establishment Year]
order by total_sale desc
-----Percentage Of Sales By outlet size
select [Outlet Size],round(sum(sales),2) as total_sales,
cast(round(sum(sales),2)*100/
(select round(sum(sales),2) from blinkit_dataset) as decimal(10,2)) pct
from blinkit_dataset
group by [Outlet Size]
order by pct
------Sales, By Outlet Location
select [Outlet Location Type],cast(sum(sales) as decimal(10,2)) as total_sale,
                             round(avg(sales),2) as avg_sale,
	                         count(*) as total_item,
		                     cast(avg(rating) as decimal(10,2)) as avg_rating,
round(round(sum(sales),2)*100/(select sum(sales) from blinkit_dataset),2) as pct
from blinkit_dataset
group by [Outlet Location Type]
order by total_sale 
------All Metrices by Outlet Type
select [Outlet Type],cast(sum(sales) as decimal(10,2)) as total_sale,
                             round(avg(sales),2) as avg_sale,
	                         count(*) as total_item,
		                     cast(avg(rating) as decimal(10,2)) as avg_rating,
round(round(sum(sales),2)*100/(select sum(sales) from blinkit_dataset),2) as pct
from blinkit_dataset
group by [Outlet Type]
order by total_sale desc