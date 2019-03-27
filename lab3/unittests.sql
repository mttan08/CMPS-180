-- unittest.sql

-- insert:

-- error: foreign constraint a, case 1
/*
INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, 
    sellerID, price, volume)
VALUES('NYSE', 'HPE', '2019-2-10 14:20:00', 
    3812, 1456, 100, 60);

-- error: foreign constraint b case 2
INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, 
    sellerID, price, volume)
VALUES('NYSE', 'AMZN', '2019-2-13 10:25:00', 
    7777, 2156, 100, 60);

-- error: foreign constraint c, case 3
INSERT INTO Trades(exchangeID, symbol, tradeTS, buyerID, 
    sellerID, price, volume)
VALUES('NYSE', 'AAPL', '2019-1-20 11:10:15', 
    7777, 1456, 100, 60);

-- error: foreign constraint d, case 4
INSERT INTO Quotes(exchangeID, symbol, quoteTS, price)
VALUES('NYSE', 'AAPL', '2019-2-10 14:20:00', 100);
*/

-- update

-- correct: constraint a, case 5
UPDATE Trades
SET exchangeID = 'NYSE', symbol = 'INL', 
tradeTS = '2018-12-22 12:30:40', buyerID = 7777, 
sellerID  = 1456, price = 100.36, volume = 50
WHERE buyerID = 1456
AND exchangeID = 'NYSE'
AND symbol = 'INL'
AND sellerID = 7257;

-- correct: constraint b, case 6
UPDATE Trades
SET exchangeID = 'NASDAQ', symbol = 'GE', 
tradeTS = '2019-2-20 11:36', buyerID = 1456,
sellerID = 9729, price = 456.22, volume = 122
WHERE exchangeID = 'NASDAQ'
AND symbol = 'GE'
AND tradeTS = '2018-9-23 12:12:07'
AND buyerID = 7777
AND sellerID = 1854;

-- correct: constraint c, case 7
UPDATE Trades
SET exchangeID = 'NASDAQ', symbol = 'AAPL',
tradeTS = '2018-6-21 12:33:43', buyerID = 9729,
sellerID = 9731, price = 1356, volume = 325
WHERE exchangeID = 'NASDAQ'
AND symbol = 'AAPL'
AND tradeTS = '2017-2-03 17:15:35'
AND buyerID = 4345
AND sellerID = 1456;

-- correct: constraint d, case 8
UPDATE Quotes
SET exchangeID = 'NYSE', symbol = 'HPE',
quoteTS = '2018-5-26 15:33:26',
price = 375.26
WHERE exchangeID = 'NYSE'
AND symbol = 'HPE'
AND quoteTS = '2018-3-20 17:35:45';

/*
-- error: constraint a, case 9
UPDATE Trades
SET exchangeID = 'NASDAQ', symbol = 'HPE',
tradeTS = '2019-2-20 13:42:00',
buyerID = 5682, sellerID = 1489,
price = 1326.50, volume = 30
WHERE exchangeID = 'NASDAQ'
AND symbol = 'HPE'
AND buyerID = 7257
AND sellerID = 1489;

-- error: constraint b, case 10
UPDATE Trades
SET exchangeID = 'NASDAQ', symbol = 'HPE',
tradeTS = '2019-2-20 13:42:00',
buyerID = 7257, sellerID = 1347,
price = 1326.50, volume = 30
WHERE exchangeID = 'NASDAQ'
AND symbol = 'HPE'
AND buyerID = 7257
AND sellerID = 1489;

-- error: constraint c, case 11
UPDATE Trades
SET exchangeID = 'NYSE', symbol = 'CMST',
tradeTS = '2019-2-20 13:42:00',
buyerID = 5682, sellerID = 1489,
price = 1326.50, volume = 30
WHERE exchangeID = 'NASDAQ'
AND symbol = 'HPE'
AND buyerID = 7257
AND sellerID = 1489;

-- error: constraint d, case 12
UPDATE Quotes
SET exchangeID = 'NASDAQ', symbol = 'GOOG',
quoteTS = '2017-2-24 12:33:45',
price = 1356.22
WHERE exchangeID = 'NYSE'
AND symbol = 'CVX';
*/
