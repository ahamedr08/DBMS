-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Find invoices with ‘X ‘as one of the items.
2. Display the items ordered in invoice number ‘X’ (use sub query).
3. Create a table CUST_TAMILNADU for all ‘Tamilnadu’ customers based on existing CUSTOMER table.

-------------------------------------------------------------------------

-- To find invoices with ‘X ‘as one of the items

SELECT * FROM INVITEM
JOIN ITEM
ON ITEM.Itemno=INVITEM.Itemno 
WHERE ITEM.Itemno='2';

-- To display the items ordered in invoice number ‘X’ (use sub query)

SELECT Itemno,Itemname,Itemprice
FROM ITEM
WHERE Itemno IN(SELECT Itemno FROM INVITEM WHERE Invno='1');

-- To create a table CUST_TAMILNADU for all ‘Tamilnadu’ customers based on existing CUSTOMER table.

CREATE TABLE CUSTOMER_TAMILNADU AS
SELECT * FROM CUSTOMER WHERE State='Tamilnadu'; 
DESC CUSTOMER_TAMILNADU;

SELECT * FROM CUSTOMER_TAMILNADU;  ---Displaying the results




