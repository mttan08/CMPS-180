// Matthew Tan
// mxtan
// CMPS 180
// RunStockMarketApplication.java

import java.sql.*;
import java.io.*;
import java.util.*;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the StockMarketApplication class
 * in a similar manner to the sample RunStoresApplication.java program.
 */


public class RunStockMarketApplication
{
    public static void main(String[] args) {
        
        Connection connection = null;
        try {
            //Register the driver
            Class.forName("org.postgresql.Driver"); 
            // Make the connection.
            // You will need to fill in your real username abd password for your
            // Postgres account in the arguments of the getConnection method below.
            connection = DriverManager.getConnection(
                "jdbc:postgresql://cmps180-db.lt.ucsc.edu/mxtan",
                "mxtan",
                "");
            
            if (connection != null)
                System.out.println("Connected to the database!");

            /* Include your code below to test the methods of the StockMarketApplication class
             * The sample code in RunStoresApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */
            /*
             * Test case 1
             */

            StockMarketApplication st = new StockMarketApplication(connection);
            List<Integer> result = st.getCustomersWhoSoldManyStocks(3);

            /*
             * Ouput of getCustomersWhoSoldManyStocks
             * when the parameter numDifferentStocksSold is 3.

             Customers who sold more than 3 different stocks are:
             1456
             1489
             9731
            */
            
            // -------------------------------------------------------------             

            /*
             * Test case 2
             */
            int updatedQuotes = st.updateQuotesForBrexit("LSE   ");

            /* 
             * Output of updateQuotesForBrexit when theExchangeID is 'LSE'

             Before update:
             mxtan=> SELECT * FROM Quotes;
             exchangeid | symbol |       quotets       |  price
             ------------+--------+---------------------+----------
             NYSE       | CVX    | 2018-11-20 13:03:24 | 11112.00
             NASDAQ     | GE     | 2018-03-16 11:01:00 |  1000.54
             LSE        | F      | 2016-12-02 12:46:00 |  2678.85
             NASDAQ     | AAPL   | 2018-01-21 21:13:21 | 12502.24
             NYSE       | CLDR   | 2018-07-25 07:04:00 |  2497.85
             NASDAQ     | AMZN   | 2018-07-14 08:24:05 |   392.97
             NYSE       | HPE    | 2018-03-20 17:35:45 |   220.54
             NYSE       | CLDR   | 2018-10-14 18:08:02 |  3000.19
             LSE        | F      | 2017-07-05 01:44:40 |   497.85
             NYSE       | HPE    | 2018-03-15 15:56:14 |   200.47
             NYSE       | CLDR   | 2018-09-11 15:48:04 |   300.12
             LSE        | ANF    | 2018-04-19 16:52:00 |  3920.45
             NASDAQ     | VZ     | 2017-12-28 12:00:00 |   120.00
             LSE        | ANF    | 2018-04-19 13:02:40 |  3502.01
             LSE        | ANF    | 2018-04-19 05:23:32 |  4020.40
             NYSE       | CLDR   | 2018-04-19 01:04:00 |  2847.19
             NASDAQ     | VZ     | 2017-12-28 13:34:12 |   150.42
             NYSE       | CLDR   | 2018-09-11 04:13:53 |   400.18
             NYSE       | HPE    | 2018-03-15 17:04:18 |   218.72
             (19 rows)
             
             After update:
             Number of quotes updated are: 5
             mxtan=> SELECT * FROM Quotes;
             exchangeid | symbol |       quotets       |  price
             ------------+--------+---------------------+----------
             NYSE       | CVX    | 2018-11-20 13:03:24 | 11112.00
             NASDAQ     | GE     | 2018-03-16 11:01:00 |  1000.54
             NASDAQ     | AAPL   | 2018-01-21 21:13:21 | 12502.24
             NYSE       | CLDR   | 2018-07-25 07:04:00 |  2497.85
             NASDAQ     | AMZN   | 2018-07-14 08:24:05 |   392.97
             NYSE       | HPE    | 2018-03-20 17:35:45 |   220.54
             NYSE       | CLDR   | 2018-10-14 18:08:02 |  3000.19
             NYSE       | HPE    | 2018-03-15 15:56:14 |   200.47
             NYSE       | CLDR   | 2018-09-11 15:48:04 |   300.12
             NASDAQ     | VZ     | 2017-12-28 12:00:00 |   120.00
             NYSE       | CLDR   | 2018-04-19 01:04:00 |  2847.19
             NASDAQ     | VZ     | 2017-12-28 13:34:12 |   150.42
             NYSE       | CLDR   | 2018-09-11 04:13:53 |   400.18
             NYSE       | HPE    | 2018-03-15 17:04:18 |   218.72
             LSE        | F      | 2016-12-02 12:46:00 |  2330.60
             LSE        | F      | 2017-07-05 01:44:40 |   433.13
             LSE        | ANF    | 2018-04-19 16:52:00 |  3410.79
             LSE        | ANF    | 2018-04-19 13:02:40 |  3046.75
             LSE        | ANF    | 2018-04-19 05:23:32 |  3497.75
             (19 rows)

             */

            // ----------------------------------------------------------------

            /*
             * Test case 3
             */

             int rewardBuyers = st.rewardBestBuyers(1456, 2);
            
            /*
             * Outuput of rewardBestBuyers when theCount is 2
             Number of trades updated: 7

             mxtan=> SELECT * FROM Trades;
             exchangeid | symbol |       tradets       | buyerid | sellerid |  price   | volume
             ------------+--------+---------------------+---------+----------+----------+--------
             NASDAQ     | GE     | 2018-09-23 12:12:07 |    7777 |     1854 |  1096.39 |    500
             NASDAQ     | GE     | 2017-09-23 12:12:07 |    7777 |     1854 |  1096.39 |    500
             NASDAQ     | HPE    | 2018-05-22 15:03:00 |    7257 |     1489 |   222.39 |    125
             NASDAQ     | GE     | 2018-06-12 06:08:12 |    9729 |     7777 |  1090.99 |    200
             NASDAQ     | HPE    | 2015-12-12 05:00:00 |    4345 |     9731 |   200.00 |    546
             NASDAQ     | AAPL   | 2017-02-03 17:15:35 |    4345 |     1456 | 12000.99 |    300
             NYSE       | INL    | 2018-03-15 14:07:00 |    1456 |     1489 |   570.99 |   1000
             NYSE       | MSFT   | 2018-12-26 12:19:40 |    9731 |     7777 |  1780.05 |    100
             NYSE       | CVX    | 2018-02-23 19:01:34 |    9731 |     1489 | 13000.99 |   1000
             NYSE       | MSFT   | 2017-01-12 03:03:12 |    5423 |     1489 | 10002.99 |     40
             NYSE       | WBA    | 2018-07-20 16:27:56 |    5423 |     1854 |    80.17 |   9720
             NYSE       | CVX    | 2016-10-13 01:01:23 |    2050 |     9731 |   123.99 |    100
             NASDAQ     | VZ     | 2018-01-24 06:01:33 |    9729 |     9731 |    58.31 |     50
             NYSE       | MSFT   | 2017-12-03 10:31:00 |    5423 |     9731 |   100.31 |    200
             NYSE       | MSFT   | 2016-01-02 20:27:20 |    5423 |     9731 |    35.31 |   1323
             NYSE       | INL    | 2018-12-13 04:53:03 |    9729 |     1456 | 12222.39 |    642
             NASDAQ     | VZ     | 2017-02-23 05:00:31 |    9729 |     1456 |    60.31 |     30
             NASDAQ     | AAPL   | 2017-02-04 17:15:35 |    2050 |     1456 | 12653.99 |    350
             NASDAQ     | GE     | 2016-08-03 02:22:35 |    2050 |     1456 |   105.39 |   1050
             NASDAQ     | HPE    | 2017-02-05 17:15:35 |    2050 |     1456 |   545.99 |    503
             NYSE       | CVX    | 2017-12-03 18:10:33 |    2050 |     1456 | 12203.99 |    172
             NYSE       | MSFT   | 2015-11-11 10:13:04 |    2050 |     1456 |   100.94 |    100             
            */


            int rewardBuyers = st.rewardBestBuyers(1456, 4);
             
            /*
             * Outuput of rewardBestBuyers when theCount is 4
             Number of trades updated: 8

             mxtan=> SELECT * FROM Trades;
             exchangeid | symbol |       tradets       | buyerid | sellerid |  price   | volume
             ------------+--------+---------------------+---------+----------+----------+--------
             NASDAQ     | GE     | 2018-09-23 12:12:07 |    7777 |     1854 |  1096.39 |    500
             NASDAQ     | GE     | 2017-09-23 12:12:07 |    7777 |     1854 |  1096.39 |    500
             NASDAQ     | HPE    | 2018-05-22 15:03:00 |    7257 |     1489 |   222.39 |    125
             NASDAQ     | GE     | 2018-06-12 06:08:12 |    9729 |     7777 |  1090.99 |    200
             NASDAQ     | HPE    | 2015-12-12 05:00:00 |    4345 |     9731 |   200.00 |    546
             NYSE       | INL    | 2018-03-15 14:07:00 |    1456 |     1489 |   570.99 |   1000
             NYSE       | MSFT   | 2018-12-26 12:19:40 |    9731 |     7777 |  1780.05 |    100
             NYSE       | CVX    | 2018-02-23 19:01:34 |    9731 |     1489 | 13000.99 |   1000
             NYSE       | MSFT   | 2017-01-12 03:03:12 |    5423 |     1489 | 10002.99 |     40
             NYSE       | WBA    | 2018-07-20 16:27:56 |    5423 |     1854 |    80.17 |   9720
             NYSE       | CVX    | 2016-10-13 01:01:23 |    2050 |     9731 |   123.99 |    100
             NASDAQ     | VZ     | 2018-01-24 06:01:33 |    9729 |     9731 |    58.31 |     50
             NYSE       | MSFT   | 2017-12-03 10:31:00 |    5423 |     9731 |   100.31 |    200
             NYSE       | MSFT   | 2016-01-02 20:27:20 |    5423 |     9731 |    35.31 |   1323
             NYSE       | INL    | 2018-12-13 04:53:03 |    9729 |     1456 | 12222.39 |    642
             NASDAQ     | VZ     | 2017-02-23 05:00:31 |    9729 |     1456 |    60.31 |     30
             NASDAQ     | AAPL   | 2017-02-04 17:15:35 |    2050 |     1456 | 12653.99 |    350
             NASDAQ     | GE     | 2016-08-03 02:22:35 |    2050 |     1456 |   105.39 |   1050
             NASDAQ     | HPE    | 2017-02-05 17:15:35 |    2050 |     1456 |   545.99 |    503
             NYSE       | CVX    | 2017-12-03 18:10:33 |    2050 |     1456 | 12203.99 |    172
             NYSE       | MSFT   | 2015-11-11 10:13:04 |    2050 |     1456 |   100.94 |    100
             NASDAQ     | AAPL   | 2017-02-03 17:15:35 |    4345 |     1456 | 12000.99 |    305
             (22 rows)
            */            
            /*******************
             * Your code ends here */
            
        }
        catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error while connecting to database: " + e);
            e.printStackTrace();
        }
        finally {
            if (connection != null) {
                // Closing Connection
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println("Failed to close connection: " + e);
                    e.printStackTrace();
                }
            }
        }
    }
}
