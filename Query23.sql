-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

QUERIES:

1. Find all the items that are cheaper than item ‘X’.
2. Create a table INV_JAN for all invoices of the month ‘January’ based on existing INVOICE table.
3. Delete from INVOICE table that are also in INV_JAN table.

-------------------------------------------------------------------------

-- To find all the items that are cheaper than item ‘X’.

SELECT * from item 
where itemprice<(select itemprice from item where itemname='Marker');

-- To create a table INV_JAN for all invoices of the month ‘January’ based on existing INVOICE table.

create table INV_JAN as (select * from INVOICE where extract(month from Invdate)='01');
desc INV_JAN;

select * from INV_JAN;

-- To delete from INVOICE table that are also in INV_JAN table.

Delete from INVOICE j where exists
( select * from INV_JAN k where j.Invno=k.Invno)








