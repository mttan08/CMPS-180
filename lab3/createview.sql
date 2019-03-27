-- createview.sql

CREATE VIEW QuotesSummary AS
SELECT R.exchangeID, R.symbol, R.theDate, S.openTime AS openingPrice, 
S.closeTime AS closingPrice, R.lowPrice, R.highPrice
FROM (SELECT q1.exchangeID, q1.symbol, DATE(q1.quoteTS) as theDate,
      MIN(q1.price) AS lowPrice, MAX(q1.price) AS highPrice
      FROM Quotes q1
      GROUP BY DATE(q1.quoteTS), q1.exchangeID, q1.symbol
      ORDER BY DATE(q1.quoteTS) ASC) AS R,

      (SELECT q1.exchangeID, q1.symbol, DATE(q1.quoteTS) AS getDate, 
       q1.price AS openTime, q2.price AS closeTime
       FROM Quotes q1, (SELECT MIN(q1.quoteTS) AS openTime,
                        MAX(quoteTS) as closeTime
                        FROM Quotes q1
                        GROUP BY DATE(q1.quoteTS), q1.exchangeID, q1.symbol
                        ORDER BY DATE(q1.quoteTS) ASC) AS quotesInfo, 
                        Quotes q2
       WHERE q1.quoteTS = quotesInfo.openTime
       AND q2.quoteTS = quotesInfo.closeTime
       ORDER BY DATE(q1.quoteTS) ASC) AS S

 WHERE R.exchangeID = S.exchangeID
 AND R.symbol = S.symbol
 AND R.theDate = S.getDate;
