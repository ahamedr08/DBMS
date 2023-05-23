-------------------------------------------------------------------------

SCHEMA STRUCTURE:

MOVIE (MovieID, Title, Genre, ReleaseDate)
THEATER (TheaterID, TheaterName, Location)
SCREENING (ScreeningID, TheaterID, MovieID, StartTime, EndTime)
TICKET (TicketID, ScreeningID, Price, SeatNumber)
BOOKING (BookingID, ScreeningID, TicketID, CustomerName, BookingDate)

QUERIES:

1. Retrieve the names of movies that are screened in all theaters.
2. Calculate the average ticket price for each movie genre.
3. Find the screenings with the highest number of booked tickets.
4. Get the customer(s) who made the highest total amount of bookings.
5. Retrieve the movies that have screenings on a specific date.

-------------------------------------------------------------------------

-- To retrieve the names of movies that are screened in all theaters

SELECT m.Title
FROM MOVIE m
WHERE NOT EXISTS (
SELECT t.TheaterID
FROM THEATER t
WHERE NOT EXISTS (
SELECT s.MovieID
FROM SCREENING s
WHERE s.MovieID = m.MovieID AND s.TheaterID = t.TheaterID
)
);

-- To calculate the average ticket price for each movie genre

SELECT m.Genre, AVG(t.Price) AS AverageTicketPrice
FROM MOVIE m
JOIN SCREENING s ON m.MovieID = s.MovieID
JOIN TICKET t ON s.ScreeningID = t.ScreeningID
GROUP BY m.Genre;

-- To find the screenings with the highest number of booked tickets

SELECT s.ScreeningID
FROM SCREENING s
JOIN BOOKING b ON s.ScreeningID = b.ScreeningID
GROUP BY s.ScreeningID
HAVING COUNT(b.TicketID) = (
SELECT MAX(BookingCount)
FROM (
SELECT COUNT(TicketID) AS BookingCount
FROM BOOKING
GROUP BY ScreeningID
) AS subquery
);

-- To get the customer(s) who made the highest total amount of bookings

SELECT b.CustomerName
FROM BOOKING b
GROUP BY b.CustomerName
HAVING SUM(
SELECT COUNT()
FROM BOOKING
WHERE CustomerName = b.CustomerName
) = (
SELECT MAX(BookingCount)
FROM (
SELECT COUNT() AS BookingCount
FROM BOOKING
GROUP BY CustomerName
) AS subquery
);

-- To retrieve the movies that have screenings on a specific date

SELECT DISTINCT m.Title
FROM MOVIE m
JOIN SCREENING s ON m.MovieID = s.MovieID
WHERE DATE(s.StartTime) = '03-03-2023'; -- Replace with the desired date

