-------------------------------------------------------------------------

SCHEMA STRUCTURE:

MOVIE (MovieID, Title, Genre, ReleaseDate)
THEATER (TheaterID, TheaterName, Location)
SCREENING (ScreeningID, TheaterID, MovieID, StartTime, EndTime)
TICKET (TicketID, ScreeningID, Price, SeatNumber)
BOOKING (BookingID, ScreeningID, TicketID, CustomerName, BookingDate)

QUERIES:

1. Count the number of movies.
2. Retrieve the names of theaters.
3. Calculate the average ticket price.
4. Get the total number of bookings.
5. Find the screenings for a specific movie.
6. Retrieve the movies released after a certain date.
7. Calculate the total revenue generated from ticket sales.
8. Get the number of available seats for a specific screening.
9. Find the customers who booked tickets for a specific movie.
10. Retrieve the movies and their respective genres.
11. Calculate the average duration of movies.
12. Get the highest-priced ticket for each movie.
13. Find the screenings with the earliest start time.
14. Retrieve the bookings made by a specific customer.
15. Calculate the total number of tickets sold.

-------------------------------------------------------------------------
-- To count the number of movies

SELECT COUNT(*) AS MovieCount
FROM MOVIE;

-- To retrieve the names of theaters

SELECT TheaterName
FROM THEATER;

-- To calculate the average ticket price

SELECT AVG(Price) AS AverageTicketPrice
FROM TICKET;

-- To get the total number of bookings

SELECT COUNT(*) AS BookingCount
FROM BOOKING;

-- To find the screenings for a specific movie

SELECT ScreeningID, StartTime, EndTime
FROM SCREENING
WHERE MovieID = (SELECT MovieID FROM MOVIE WHERE Title = 'Veeram');

-- To retrieve the movies released after a certain date

SELECT Title
FROM MOVIE
WHERE ReleaseDate > '01-01-2023'; -- Replace with the desired date

-- To calculate the total revenue generated from ticket sales

SELECT SUM(Price) AS TotalRevenue
FROM TICKET;

-- To get the number of available seats for a specific screening

SELECT COUNT(*) AS AvailableSeats
FROM TICKET
WHERE ScreeningID = 'ScreeningID';

-- To find the customers who booked tickets for a specific movie

SELECT DISTINCT CustomerName
FROM BOOKING
WHERE ScreeningID IN (
SELECT ScreeningID
FROM SCREENING
WHERE MovieID = (SELECT MovieID FROM MOVIE WHERE Title = 'Friends')
);

-- To retrieve the movies and their respective genres

SELECT Title, Genre
FROM MOVIE;

-- To calculate the average duration of movies

SELECT AVG(EndTime - StartTime) AS AverageDuration
FROM SCREENING;

-- To get the highest-priced ticket for each movie

SELECT m.Title, MAX(t.Price) AS HighestPrice
FROM MOVIE m
JOIN SCREENING s ON m.MovieID = s.MovieID
JOIN TICKET t ON s.ScreeningID = t.ScreeningID
GROUP BY m.Title;

-- To find the screenings with the earliest start time

SELECT ScreeningID, StartTime
FROM SCREENING
WHERE StartTime = (
SELECT MIN(StartTime)
FROM SCREENING
);

-- To retrieve the bookings made by a specific customer

SELECT *
FROM BOOKING
WHERE CustomerName = 'Ahamed';

-- To calculate the total number of tickets sold

SELECT COUNT(*) AS TotalTicketsSold
FROM TICKET;