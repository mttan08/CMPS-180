-- queryview.sql

SELECT R.exchangeName, S.stockName, COUNT(S.stockName) AS numHighClosings
FROM
     (SELECT e.exchangeName, s.stockName, q1.theDate  AS numHighClosings
      FROM Exchanges e, Stocks s, QuotesSummary q1
      WHERE q1.closingPrice = q1.highPrice
      AND e.exchangeID = s.exchangeID
      AND q1.exchangeID = s.exchangeID
      AND q1.symbol = s.symbol
      GROUP BY q1.theDate, e.exchangeName, s.stockName) AS R,

     (SELECT stockName, COUNT(stockName)
      FROM (SELECT e.exchangeName, s.stockName, q1.theDate AS numHighClosings
            FROM Exchanges e, Stocks s, QuotesSummary q1
            WHERE q1.closingPrice = q1.highPrice
            AND e.exchangeID = s.exchangeID
            AND q1.exchangeID = s.exchangeID
            AND q1.symbol = s.symbol
            GROUP BY q1.theDate, e.exchangeName, s.stockName) AS stockInfo
      GROUP BY stockName
      HAVING COUNT (stockName) >= 2) AS S

WHERE R.stockName = S.stockName
GROUP BY R.exchangeName, S.stockName
HAVING COUNT(S.stockName) >= 2;

/* Result of query using lab3_data_loading.sql 
before deleting (NYSE, CLDR)  and (NASDAQ, ANF):
   exchangename          |   stockname   | numhighclosings
-------------------------+---------------+-----------------
 New York Stock Exchange | Cloudera,Inc. |               3
 New York Stock Exchange | HP Enterprise |               2
*/

DELETE FROM Quotes
WHERE exchangeID = 'NYSE'
AND symbol = 'CLDR';

DELETE FROM Quotes
WHERE exchangeID = 'NASDAQ'
AND symbol = 'ANF';

SELECT R.exchangeName, S.stockName, COUNT(S.stockName) AS numHighClosings
FROM
     (SELECT e.exchangeName, s.stockName, q1.theDate  AS numHighClosings
      FROM Exchanges e, Stocks s, QuotesSummary q1
      WHERE q1.closingPrice = q1.highPrice
      AND e.exchangeID = s.exchangeID
      AND q1.exchangeID = s.exchangeID
      AND q1.symbol = s.symbol
      GROUP BY q1.theDate, e.exchangeName, s.stockName) AS R,

     (SELECT stockName, COUNT(stockName)
      FROM (SELECT e.exchangeName, s.stockName, q1.theDate AS numHighClosings
            FROM Exchanges e, Stocks s, QuotesSummary q1
            WHERE q1.closingPrice = q1.highPrice
            AND e.exchangeID = s.exchangeID
            AND q1.exchangeID = s.exchangeID
            AND q1.symbol = s.symbol
            GROUP BY q1.theDate, e.exchangeName, s.stockName) AS stockInfo
      GROUP BY stockName
      HAVING COUNT (stockName) >= 2) AS S

WHERE R.stockName = S.stockName
GROUP BY R.exchangeName, S.stockName
HAVING COUNT(S.stockName) >= 2;

/* Result of query using lab3_data_loading.sql 
after deleting (NYSE, CLDR)  and (NASDAQ, ANF):
      exchangename       |   stockname   | numhighclosings
-------------------------+---------------+-----------------
 New York Stock Exchange | HP Enterprise |               2

*/
