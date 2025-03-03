# SQL-Casestudy
# NFT Sales Analysis Project
## Overview
This project analyzes real-world NFT sales data from one of the most famous NFT projects, Cryptopunks. The dataset includes sales transactions from January 1st, 2018 to December 31st, 2021. Each row in the dataset represents a sale of an NFT.
## Dataset Description and Source
The dataset contains the following columns:
•	buyer_address: Ethereum address of the buyer who purchased the NFT.
•	eth_price: Price of the NFT in Ethereum (ETH) at the time of the transaction.
•	usd_price: Equivalent price of the NFT in US Dollars (USD) at the time of the transaction.
•	seller_address: Ethereum address of the seller who sold the NFT.
•	event_date: Day on which the transaction took place.
•	utc_timestamp: Exact timestamp of the transaction in Coordinated Universal Time (UTC).
•	token_id: Unique identifier of the NFT token
•	transaction_hash: Unique hash of the transaction, which can be used to look up the transaction on the blockchain.
•	name: Name of the NFT.
<a href = "https://github.com/Poonam3094/SQL-Casestudy/blob/main/nft%20data.csv">Nft Dataset</a>

## Case Study Instructions
You are tasked with analyzing the provided NFT sales dataset to answer the following prompts:
1.	Sales Count: Determine the total number of sales that occurred during this time period.
2.	Top 5 Most Expensive Transactions: Return the top 5 most expensive transactions (by USD price) with the name, ETH price, USD price, and the date.
3.	Moving Average of USD Price: Create a table with a row for each transaction including an event column, a USD price column, and a moving average of USD price that averages the last 50 transactions.
4.	Average Sale Price by NFT Name: Return all NFT names and their average sale price in USD, sorted in descending order.
5.	Sales by Day of the Week: Return each day of the week, the number of sales that occurred on that day, and the average price in ETH, ordered by the count of transactions in ascending order.
6.	Summary Column: Construct a column that describes each sale, including the NFT name, buyer, seller, date, and sale price in USD rounded to the nearest thousandth.
7.	1919 Purchases View: Create a view called “1919_purchases” containing sales where “0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685” was the buyer.
8.	Highest and Lowest Prices: Return a unioned query containing the highest and lowest prices each NFT was bought for, with a status column indicating “highest” or “lowest”.
9.	Most Sold NFT by Month/Year: Identify the NFT that sold the most each month/year combination, including the name and price in USD, ordered chronologically.
10.	Monthly Sales Volume: Return the total sales volume rounded to the nearest hundred on a monthly basis.
11.	Transactions Count for Wallet: Count the number of transactions for the wallet “0x1919db36ca2fa2e15f9000fd9cdc2edcf863e685”.
12.	Estimated Average Value Calculator: Create a daily average value calculator excluding daily outlier sales where the purchase price is below 10% of the daily average price, then calculate the daily average of the remaining transactions.

## Solution
<a href = "">SQL Queries Script</a>
    
