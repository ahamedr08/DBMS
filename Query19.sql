-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Find all possible combinations of customers and items (Cartesian product).
2. Find the total price for each invoice.

-------------------------------------------------------------------------

-- To find all possible combinations of customers and items (Cartesian product).

SELECT * FROM CUSTOMER 
CROSS JOIN ITEM;


-- To find the total price for each invoice.

SELECT INVITEM.Invno, SUM(INVITEM.Qty*ITEM.Itemprice) AS TOTAL_PRICE
FROM INVITEM
INNER JOIN ITEM 
ON INVITEM.Itemno = ITEM.Itemno 
GROUP BY INVITEM.Invno;



