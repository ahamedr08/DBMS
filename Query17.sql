-------------------------------------------------------------------------

SCHEMA STRUTURE:

CUSTOMER( Custno, custname, state, phone )
ITEM ( Itemno, Itemname, Itemprice, QtyOnhand)
INVOICE ( Invno , Invdate , Custno )
INVITEM ( Invno , Itemno , Qty )

SIMPLE QUERIES:

1. Display item name and price as single column like “<Item> price is <price>”
2. Find items with the letter ‘a’ in their name.
3. Display all the customers from ‘Tamil Nadu’ alphabetically.
4. Display invoice dates in ‘January 10, 2008’, format.
5. Display all item prices rounded to the nearest dollar.

-------------------------------------------------------------------------

-- To display item name and price as single column like “<Item> price is <price>”

SELECT Itemname||' '||'price is'||' '||ItemPrice AS Item_Prices FROM ITEM ;

-- To find items with the letter ‘a’ in their name.

Select Itemname from ITEM where Itemname like '%a%';

-- To display all the customers from ‘Tamil Nadu’ alphabetically.

Select custname, state from Customer where state='TamilNadu'
order by custname asc;

-- To display invoice dates in ‘January 10, 2008’, format.

Select to_char(Invdate,'Month') ||' '||extract(day from Invdate)||','||extract(year
from Invdate) as Invoice_date from INVOICE;

-- To display all item prices rounded to the nearest dollar.

SELECT Itemname,ROUND(Itemprice) as COST FROM ITEM;
