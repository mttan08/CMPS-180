-- Matthew Tan
-- mxtan
-- query1.sql

SELECT customerId, custName, address
FROM Customers
WHERE custName LIKE '%FAKE%' 
AND isValidCustomer = TRUE;
