--This is to check the entire dataset in dbo.2018, to view the columns and rows in the data 
--it also gives us basic understanding of the data
select * from dbo.['2018]

--This returns the total number of rows in the dataset
--There are 21,996 rows
select COUNT(*) 
from dbo.['2018]

--There are 32 columns

--This is just to check the different table types
select * from dbo.['2018]

select * from dbo.['2019]

select * from dbo.['2020]

--to combine all 3  tables using UNION
--also using the hotel column to join them together

select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020]

with hotel as (
select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select * from hotel

--stays in weekend and week night creating a new column for the weeknight and weekday
--and multiply by adr which is the daily rates from the hotel above syntax
--give column name revenue as an alias because the original data didnt have revenue column
with hotel as (
 select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select (stays_in_week_nights+stays_in_weekend_nights)*adr as revenue from hotel


--another column to check if the revenue is increasing per year 
--using the arrival date year
with hotel as (
 select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select 
arrival_date_year,
(stays_in_week_nights+stays_in_weekend_nights)*adr as revenue 
from hotel

--group and sum the revenue by year
with hotels as (
 select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select 
arrival_date_year,
sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as revenue 
from hotels
group by arrival_date_year

--the revenue is growing, if we check the revenue in millions, there is an increase

---to check by the type of hotel
--round the total sum of revenue to 2d.p
--there is a great diff between 2018/2019
with hotels as 
(
 select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select 
arrival_date_year,
hotel,
round(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as revenue 
from hotels
group by arrival_date_year,hotel


--to check the other tables, market segment and meal type
select * from dbo.market_segment
select * from dbo.meal_cost

--now join them to the other table using union
--left join, brings back everything in the table 
--and also the meal cost column
with hotels as 
(
 select * from dbo.['2018]
union
select * from dbo.['2019]
union
select * from dbo.['2020])

select * from hotels
left join dbo.market_segment
on hotels.market_segment = market_segment.market_segment
left join 
dbo.meal_cost
on meal_cost.meal = hotels.meal

--taking the sql query into power bi
