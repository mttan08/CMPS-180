-- Matthew Tan
-- mxtan
-- CMPS 180
-- lab1

DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

ALTER ROLE mxtan SET SEARCH_PATH to Lab1;

-- Exchanges table
CREATE TABLE Exchanges (
    exchangeID CHAR(6) PRIMARY KEY,
    exchangeName VARCHAR(30),
    address VARCHAR(30)
);

-- Stocks table
CREATE TABLE Stocks (
    exchangeID CHAR(6),
    symbol CHAR(4),
    PRIMARY KEY(exchangeID, symbol),
    stockName VARCHAR(30),
    address VARCHAR(30)
);

-- Customers table
CREATE TABLE Customers (
    customerID INT PRIMARY KEY,
    custName VARCHAR(30),
    address VARCHAR(30),
    category CHAR(1),
    isValidCustomer BOOLEAN
);

-- Traders table
CREATE TABLE Trades (
    exchangeID CHAR(6),
    symbol CHAR(4),
    tradeTS TIMESTAMP,
    PRIMARY KEY(exchangeID, symbol, tradeTS),
    buyerID INT,
    sellerID INT,
    price DECIMAL(7, 2),
    volume INT
);

-- Quotes table
CREATE TABLE Quotes (
    exchangeID CHAR(6),
    symbol CHAR(4),
    quoteTS TIMESTAMP,
    PRIMARY KEY(exchangeID, symbol, quoteTS),
    price DECIMAL(7, 2)
);
