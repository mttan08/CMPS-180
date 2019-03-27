-- combine.sql

-- a)
BEGIN TRANSACTION;

INSERT INTO Customers(customerID, custName, address, isValidCustomer, category)
SELECT n.customerID, n.custName, n.address, TRUE, NULL
FROM NewCustomers n
WHERE n.customerID NOT IN (SELECT c.customerID
                           FROM Customers c);
-- b)
UPDATE Customers
SET custName = NewCustomers.custName,
address = NewCustomers.address,
isValidCustomer = TRUE
FROM NewCustomers
WHERE Customers.customerID = NewCustomers.customerID;

COMMIT;

