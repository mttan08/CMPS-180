-- Matthew Tan
-- mxtan
-- query2.sql

SELECT s.stockName AS name, s.symbol
FROM Stocks s, Exchanges e
WHERE s.exchangeID = e.exchangeID
AND e.exchangeName NOT LIKE 'NASDAQ Stock Exchange';
