-- Matthew Tan
-- mxtan
-- CMPS 180
-- lab2

DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;

ALTER ROLE mxtan SET SEARCH_PATH to Lab2;

-- Exchanges table
CREATE TABLE Exchanges (
    exchangeID CHAR(6) PRIMARY KEY,
    exchangeName VARCHAR(30) UNIQUE,
    address VARCHAR(30)
);

-- Stocks table
CREATE TABLE Stocks (
    exchangeID CHAR(6),
    symbol CHAR(4),
    PRIMARY KEY(exchangeID, symbol),
    stockName VARCHAR(30) NOT NULL UNIQUE,
    address VARCHAR(30)
);

-- Customers table
CREATE TABLE Customers (
    customerID INT PRIMARY KEY,
    custName VARCHAR(30),
    address VARCHAR(30),
    UNIQUE(custName, address),
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
    price DECIMAL(7, 2) NOT NULL,
    volume INT NOT NULL
);

-- Quotes table
CREATE TABLE Quotes (
    exchangeID CHAR(6),
    symbol CHAR(4),
    quoteTS TIMESTAMP,
    PRIMARY KEY(exchangeID, symbol, quoteTS),
    price DECIMAL(7, 2)
);
