-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Display how many different items are available for customers.
2. Find the two items with the lowest quantity on hand.
3. Find invoices in which three or more items are ordered.
4. Display all item quantities and item prices for invoices.

-------------------------------------------------------------------------

-- To display how many different items are available for customers.

select distinct ItemName from Item;

-- To find the two items with the lowest quantity on hand

select itemname, qtyonhand from item 
order by qtyonhand 
FETCH FIRST 2 ROWS ONLY ;

-- To find invoices in which three or more items are ordered.

select invno,qty from invitem
join item on
invitem.itemno=item.itemno
where qty>=3;

-- To display all item quantities and item prices for invoices.

SELECT qtyonhand,itemprice
from item
join Invitem on item.itemno=invitem.itemno
join Invoice on invitem.invno=invoice.invno;






