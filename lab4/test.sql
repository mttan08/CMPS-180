-- q1_f1.sql
/*
SELECT sellerID, COUNT(price * volume), COUNT(symbol)
FROM Trades
GROUP BY sellerID
HAVING COUNT(symbol) >= 3;

SELECT exchangeID, price
FROM Quotes
WHERE exchangeID = 'NYSE';
*/

/*
SELECT  buyerID, sellerID, SUM(price * volume)
FROM Trades
GROUP BY buyerID, sellerID
ORDER BY SUM(price * volume) DESC
LIMIT 3;

UPDATE Trades
SET volume = volume + 50
WHERE buyerID IN (SELECT customerID
                  FROM Customers
                  WHERE category = 'H'
                  LIMIT 3);

UPDATE Trades
SET volume = volume + 20
WHERE buyerID IN (SELECT customerID
                  FROM Customers
                  WHERE category = 'M'
                  LIMIT 3);

UPDATE Trades
SET volume = volume + 5
WHERE buyerID IN (SELECT customerID
                  FROM Customers
                  WHERE category = 'L'
                  LIMIT 3);
*/

/*
SELECT sellerID, symbol
FROM Trades
WHERE sellerID = 1456;

SELECT sellerID, symbol
FROM Trades
WHERE sellerID = 1489;

SELECT sellerID, symbol
FROM Trades
WHERE sellerID = 9731;

SELECT DISTINCT sellerID
FROM Trades;
*/

-- before update:
SELECT exchangeID, price, price * 0.87
FROM Quotes
WHERE exchangeID = 'LSE';
