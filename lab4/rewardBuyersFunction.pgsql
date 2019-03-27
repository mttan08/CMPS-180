-- rewardBuyersFunction.pgsql

CREATE FUNCTION rewardBuyersFunction(INTEGER, INTEGER) 
   RETURNS INTEGER AS $$
DECLARE theSellerID ALIAS FOR $1;
DECLARE theCount ALIAS FOR $2;
DECLARE seller_ID INT;
DECLARE buyer_ID INT;
DECLARE counter INTEGER := 0;
DECLARE totalUpdatedTrades INTEGER := 0;
DECLARE cat VARCHAR(1);
DECLARE inc INTEGER := 0;
DECLARE numTrades INTEGER;
DECLARE c CURSOR FOR
SELECT buyerID, sellerID, SUM(price*volume) AS totalCost
FROM Trades
WHERE sellerID = theSellerID
GROUP BY buyerID, sellerID
ORDER BY sum(price*volume) DESC
LIMIT theCount;

BEGIN
    OPEN c;
    LOOP
    EXIT WHEN counter = theCount;
        FETCH c INTO buyer_ID, seller_ID;
        IF seller_ID = theSellerID  THEN
          SELECT category INTO cat FROM Customers WHERE customerID = buyer_ID;
          IF cat = 'H' THEN
              inc := 50;
          ELSEIF cat = 'M' THEN
              inc := 20;
          ELSEIF cat = 'L' THEN
              inc := 5;
          ELSE
              inc := 1;
          END IF;
          UPDATE Trades SET volume = volume + inc
          WHERE sellerID = theSellerID AND buyerID = buyer_ID;

          SELECT COUNT(buyerID) INTO numTrades 
          FROM Trades 
          WHERE sellerID = theSellerID AND buyerID = buyer_ID;

          totalUpdatedTrades := totalUpdatedTrades + numTrades;
        END IF;
        counter := counter + 1;

    END LOOP;
    CLOSE c;
RETURN totalUpdatedTrades;
END;

$$ LANGUAGE plpgsql;