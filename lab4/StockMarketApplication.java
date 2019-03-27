// Matthew Tan
// mxtan
// CMPS 180
// StockMarketApplication.java

import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the StockMarket database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the
 * Connection object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case
 * an error occurs in the database, then the method should print an
 * error message and call System.exit(-1);
 */

public class StockMarketApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public StockMarketApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    /**
     * Takes as argument an integer called numDifferentStocksSold.
     * Returns the customerID for each customer in Customers that has been the seller of at least
     * numDifferentStocksSold different stocks in Trades.
     * If numDifferentStocksSold is not positive, that's an error.
     */

    public List<Integer> getCustomersWhoSoldManyStocks(int numDifferentStocksSold)
    {
        List<Integer> result = new ArrayList<Integer>();
        // your code here

        if (numDifferentStocksSold < 0)
        {
            System.out.println("Error!");
            System.exit(1);
        }

        try 
        {
            System.out.println("Customers who sold more than " 
                + numDifferentStocksSold + " different stocks are:");
            String statement = "SELECT c.customerID"
                + "\nFROM Customers c, Trades t" 
                + "\nWHERE c.customerID = t.sellerID"
                + "\n GROUP BY c.customerID"
                + "\n HAVING COUNT(DISTINCT symbol) >= " + numDifferentStocksSold;
            PreparedStatement st = connection.prepareStatement(statement);
            ResultSet rs = st.executeQuery();
            while(rs.next())
            {
                result.add(rs.getInt(1));
                System.out.println(rs.getString(1));
            }
            rs.close();
            st.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        // end of your code
        return result;
    }


    /**
     * The updateQuotesForBrexit method has one string argument, theExchangeID, which is the exchangeID
     * for an exchange. updateQuotesForBrexit should update price in Quotes for every quote that has
     * that exchangedID, multiplying price by 0.87.
     * updateQuotesForBrexit should return the number of quotes whose prices were updated.
     */

    public int updateQuotesForBrexit(String theExchangeID)
    {
        // your code here; return 0 appears for now to allow this skeleton to compile.
        int result = 0;
        try
        {
            String statement = "UPDATE Quotes" +
                "\nSET price = price * 0.87" +
                "\nWHERE exchangeID = ?";
            //System.out.println("statement is: " + statement);
            PreparedStatement st = connection.prepareStatement(statement);
            st.setString(1, theExchangeID);
            result = st.executeUpdate();         
            System.out.println("Number of quotes updated are: " + result);
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

        return result;
        // end of your code
    }


    /**
     * rewardBestBuyers has two integer parameters, theSellerID and theCount.  It invokes a stored
     * function rewardBuyersFunction that you will need to implement and store in the database
     * according to the description in Section 5.  rewardBuyersFunction should have the same two
     * parameters, theSellerID and theCount.
     *
     * Trades has a volume attribute.  rewardBuyersFunction will increase the volume for some trades
     * whose sellerID is theSellerID; Section 5 explains which trade volumes should be increased,
     * and how much they should be increased.  The rewardBestBuyers method should return the same
     * integer result as the rewardBuyersFunction stored function.
     *
     * The rewardBestBuyers method must only invoke the stored function rewardBuyersFunction, which
     * does all of the assignment work; do not implement the rewardBestBuyers method using a bunch of
     * SQL statements through JDBC.  However, rewardBestBuyers should check to see whether theCount
     * is greater than 0, and report an error if it’s not.
     */

    public int rewardBestBuyers (int theSellerID, int theCount)
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;
        try 
        {
            CallableStatement cStmnt = connection.prepareCall(
                "{? = CALL rewardBuyersFunction(?, ?)}");
            // your code here
            cStmnt.registerOutParameter(1, Types.INTEGER);
            cStmnt.setInt(2, theSellerID);
            cStmnt.setInt(3, theCount);
            cStmnt.execute();
            storedFunctionResult = cStmnt.getInt(1);
            System.out.println("Number of trades updated: " + storedFunctionResult);

            // end of your code
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return storedFunctionResult;

    }

};
