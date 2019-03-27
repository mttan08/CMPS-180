-- general.sql

ALTER TABLE Quotes ADD CHECK(price > 0);

ALTER TABLE Trades ADD CONSTRAINT positive_cost CHECK((price * volume) > 0);

ALTER TABLE Trades ADD CHECK(buyerID <> sellerID);

ALTER TABLE Customers ADD CHECK(category = 'H' 
    AND isValidCustomer = TRUE OR (category <> 'H'));
