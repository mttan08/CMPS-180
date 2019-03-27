-- Matthew Tan
-- mxtan
-- query3.sql

SELECT DISTINCT s.exchangeID, s.stockName
FROM Stocks s, Quotes q
WHERE q.price = ANY (SELECT q.price
                     FROM Quotes q
                     WHERE q.price < 314.15)
AND s.symbol = q.symbol
AND s.exchangeID = q.exchangeID;

