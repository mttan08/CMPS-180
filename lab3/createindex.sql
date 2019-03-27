-- createindex.sql

CREATE INDEX LookupTrades ON Trades(buyerID, sellerID);

/* Without running index:
                                         QUERY PLAN
------------------------------------------------------------------------------------------
 Seq Scan on trades  (cost=0.00..21.10 rows=1 width=82) (actual time=0.023..0.023 
      rows=0 loops=1)
    Filter: ((buyerid = 1456) AND (sellerid = 7777))
    Rows Removed by Filter: 13
 Planning time: 0.351 ms
 Execution time: 0.053 ms
(5 rows)

*/

/* With running index:
                                           QUERY PLAN
------------------------------------------------------------------------------------------
 Seq Scan on trades  (cost=0.00..1.20 rows=1 width=82) (actual time=0.007..0.007 
    rows=0 loops=1)
    Filter: ((buyerid = 1456) AND (sellerid = 7777))
    Rows Removed by Filter: 13
 Planning time: 0.212 ms
 Execution time: 0.027 ms
(5 rows)

*/
