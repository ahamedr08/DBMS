-------------------------------------------------------------------------

SCHEMA STRUCTURE:

BOOK (BookID, Title, Author, PublicationYear, Price)
PURCHASE (PurchaseID, BookID, CustomerName, PurchaseDate, Quantity)

QUERIES:

1. Calculate the total price for each purchase.
2. Find the books published after a certain year.
3. Retrieve the names of customers who made purchases on a specific date.

-------------------------------------------------------------------------

-- To calculate the total price for each purchase

SELECT PurchaseID, SUM(Price * Quantity) AS TotalPrice
FROM PURCHASE p
JOIN BOOK b ON p.BookID = b.BookID
GROUP BY PurchaseID;

-- To find the books published after a certain year

SELECT Title, Author
FROM BOOK
WHERE PublicationYear > 2000; -- Replace with the desired year

-- To retrieve the names of customers who made purchases on a specific date

SELECT CustomerName
FROM PURCHASE
WHERE PurchaseDate = '02-02-2023'; -- Replace with the desired date