-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Use an outer join to display items ordered and not ordered.
2. Display invoices, customer name and item names together (multiple join).
3. Find invoices with ‘X‘ as one of the items by using sub query.

-------------------------------------------------------------------------

-- To use an outer join to display items ordered and not ordered.

SELECT Item.ItemNo,ItemName,Qty
FROM Item
FULL OUTER JOIN INVITEM
ON Item.ItemNo = Invitem.ItemNo;

-- To display invoices, customer name and item names together (multiple join).

SELECT i.Invno,Invdate,CustName,ItemName
from Invoice i
join CUSTOMER on i.Custno= customer.custno
join INVITEM on i.Invno= Invitem.Invno
JOIN ITEM on Invitem.Itemno=Item.itemno;

-- To find invoices with ‘X‘ as one of the items by using sub query.

SELECT * from Invoice where Invno=(select Invno from Invitem where Itemno=(Select
Itemno from Item where Itemname='Pen'));








