-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

SIMPLE QUERIES:

1. Display unique invoice numbers.
2. Find the total value of each item based on quantity on hand.
3. Sort all customers by their state and also alphabetically.
4. Find the payment due date if the payment is due in two months from the invoice date.
5. List the Item name which is available in highest quantity.

-------------------------------------------------------------------------

-- To display unique invoice numbers.

SELECT DISTINCT Invno
FROM INVOICE;

-- To find the total value of each item based on quantity on hand.

SELECT Itemno,Itemname,Itemprice,Itemprice*Qtyonhand AS TOTALVALUE
FROM ITEM;

-- To sort all customers by their state and also alphabetically.

SELECT * FROM CUSTOMER
ORDER BY State;

-- To find the payment due date if the payment is due in two months from the invoice date.

SELECT ADD_MONTHS(invdate,2) Duedate from INVOICE;

-- To list the Item name which is available in highest quantity.

SELECT Itemname
FROM ITEM
Qtyonhand=(SELECT MAX(Qtyonhand) FROM ITEM);