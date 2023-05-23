-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Find the total, average, highest and lowest unit prices
2. Count the number of items ordered in each invoice.

-------------------------------------------------------------------------

-- To find the total, average, highest and lowest unit prices

SELECT
SUM(Itemprice) AS TOTAL_UNITPRICE, 
AVG(Itemprice) AS AVERAGE_UNITPRICE, 
MAX(Itemprice) AS HIGHEST_UNITPRICE,
MIN(Itemprice) AS LOWEST_UNITPRICE 
FROM ITEM;


-- To count the number of items ordered in each invoice.

SELECT Invno,SUM(Qty) AS NUMBER_OF_ITEMS_ORDERED 
FROM INVITEM
GROUP BY Invno;


