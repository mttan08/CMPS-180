-- Matthew Tan
-- mxtan
-- query4.sql

SELECT DISTINCT tc.exchangeID, tc.symbol, tc.buyerID,
cost AS theCost, c1.category
FROM (SELECT *
      FROM Customers c
      WHERE c.category IS NOT NULL
      AND c.isValidCustomer = TRUE) c1,
      (SELECT t.exchangeID, t.symbol, t.buyerID,
              t.price * t.volume AS cost
              FROM Trades t
              WHERE t.price * t.volume >= 5000) tc
WHERE c1.customerID = tc.buyerID;

