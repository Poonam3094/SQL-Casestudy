## Data Analysis - Nft Case study

use nft_data;
select * from pricedata limit 10 ;

## 1.	How many sales occurred during this time period? 
SELECT 
    COUNT(*)
FROM
    pricedata;

# 2.	Return the top 5 most expensive transactions (by USD price) for this data set.
       # Return the name, ETH price, and USD price, as well as the date. 
SELECT 
    name, eth_price, usd_price, event_date
FROM
    pricedata
ORDER BY usd_price DESC
LIMIT 5;

# 3.	Return a table with a row for each transaction with an event column, a USD price column, and a moving average of USD price that averages the last 50 transactions.

select event_date,usd_price,avg(usd_price) over(order by event_date desc Rows between 49 preceding and current row) as moving_average from pricedata;

create temporary table T_moving_avg(event_date date,usd_price int,moving_average int);
insert into T_moving_avg
select event_date,usd_price,avg(usd_price) over(order by event_date desc Rows between 49 preceding and current row) as moving_average from pricedata;

select * from T_moving_avg;

# 4.	Return all the NFT names and their average sale price in USD. Sort descending. Name the average column as average_price.
 select name,usd_price,avg(usd_price) over (order by usd_price desc) as average_price from pricedata;
 
 # 5.	Return each day of the week and the number of sales that occurred on that day of the week, as well as the average price in ETH. Order by the count of transactions in ascending order.
SELECT 
    DAYNAME(event_date) AS week_day,
    COUNT(*) AS count_of_transactions,
    AVG(eth_price)
FROM
    pricedata
GROUP BY week_day
ORDER BY count_of_transactions;

# 6.	Construct a column that describes each sale and is called summary. The sentence should include who sold the NFT name, who bought the NFT, who sold the NFT, the date, and what price it was sold for in USD rounded to the nearest thousandth.
 # Here’s an example summary:
 #“CryptoPunk #1139 was sold for $194000 to 0x91338ccfb8c0adb7756034a82008531d7713009d from 0x1593110441ab4c5f2c133f21b0743b2b43e297cb on 2022-01-14”

SELECT 
    CONCAT(name,
            ' was sold for ',
            ROUND(usd_price, 3),
            ' to ',
            buyer_address,
            ' from ',
            seller_address,
            ' on ',
            event_date) AS Summary
FROM
    pricedata;
    
# 7.	Create a view called “1919_purchases” and contains any sales where “0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685” was the buyer.

create view 1919_purchases as
select * from pricedata where buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685';

select * from 1919_purchases;

# 9.	Return a unioned query that contains the highest price each NFT was bought for and a new column called status saying “highest” with a query that has the lowest price each NFT was bought for and the status column saying “lowest”. The table should have a name column, a price column called price, and a status column. Order the result set by the name of the NFT, and the status, in ascending order.
  
select name,Max(usd_price) as price,'highest' as status from pricedata group by name 
Union
select name,Min(usd_price) as price,'lowest' as status from pricedata group by name order by name asc ,status asc;

# 10.	What NFT sold the most each month / year combination? Also, what was the name and the price in USD? Order in chronological format.
SELECT 
    name,
    SUM(usd_price),
    COUNT(name) AS no_sold,
    DATE_FORMAT(event_date, '%m /%y') AS month_year
FROM
    pricedata
GROUP BY name , month_year
ORDER BY no_sold desc, month_year desc;
 
# 11.	Return the total volume (sum of all sales), round to the nearest hundred on a monthly basis (month/year).

SELECT 
    ROUND(SUM(eth_price), - 2),
    CONCAT(MONTHNAME(event_date), YEAR(event_date)) AS month_year
FROM
    pricedata
GROUP BY month_year;

# 12.	Count how many transactions the wallet "0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685"had over this time period.

SELECT 
    COUNT(*)
FROM
    pricedata
WHERE
    seller_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685'
        OR buyer_address = '0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685'; 
        
#12.	Create an “estimated average value calculator” that has a representative price of the collection every day based off of these criteria:
  #- Exclude all daily outlier sales where the purchase price is below 10% of the daily average price
 #- Take the daily average of remaining transactions
# a) First create a query that will be used as a subquery. Select the event date, the USD price, and the average USD price for each day using a window function. Save it as a temporary table.
 #b) Use the table you created in Part A to filter out rows where the USD prices is below 10% of the daily average and return a new estimated value which is just the daily average of the filtered data.
  
WITH daily_avg AS (
    SELECT 
        event_date,
        usd_price,
        AVG(usd_price) OVER (PARTITION BY event_date) AS daily_avg_price
    FROM 
        pricedata
)
SELECT 
    event_date,
    AVG(usd_price) AS estimated_avg_value
FROM 
    daily_avg
WHERE 
    usd_price >= 0.1 * daily_avg_price
GROUP BY 
    event_date
ORDER BY 
    event_date;



