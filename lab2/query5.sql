-- Matthew Tan
-- mxtan
-- query5.sql

SELECT DISTINCT tr.exchangeID, s.stockName, 
cb.custName AS buyerName, cs.custName AS sellerName
FROM Stocks s, (SELECT t.exchangeID, t.symbol,
                  t.tradeTS, t.buyerID, t.sellerID
                  FROM Trades t
                  WHERE t.tradeTS < '2018-01-01 12:00:00') tr,
                  Customers cb, Customers cs
WHERE s.symbol = tr.symbol
AND cb.customerID = tr.buyerID
AND cs.customerID = tr.sellerID;
