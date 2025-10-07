CREATE DATABASE blog_db;

USE blog_db;

-- DROP TABLE Authors;
CREATE TABLE Authors
(
    author_id   INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

-- DROP TABLE Articles;
CREATE TABLE Articles
(
    article_id INT PRIMARY KEY AUTO_INCREMENT,
    title      VARCHAR(150) NOT NULL,
    word_count INT,
    views      INT,
    author_id  INT,
    FOREIGN KEY (author_id) REFERENCES Authors (author_id)
);

INSERT INTO Authors (author_name)
VALUES ('Maria Charlotte'),
       ('Juan Perez'),
       ('Gemma Alcocer');

INSERT INTO Articles (title, word_count, views, author_id)
VALUES ('Best Paint Colors', 814, 14, 1),
       ('Small Space Decorating Tips', 1146, 221, 2),
       ('Hot Accessories', 986, 105, 1),
       ('Mixing Textures', 765, 22, 1),
       ('Kitchen Refresh', 1242, 307, 2),
       ('Homemade Art Hacks', 1002, 193, 1),
       ('Refinishing Wood Floors', 1571, 7542, 3);


-- DROP TABLE Customers;
CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY AUTO_INCREMENT,
                           customer_name VARCHAR(100) NOT NULL,
                           customer_status VARCHAR(20) CHECK (customer_status in ('Silver', 'Gold', 'None')),
                           total_customer_mileage INT NOT NULL CHECK (total_customer_mileage >= 0)
);

-- DROP TABLE Aircraft;
CREATE TABLE Aircrafts (
                           aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
                           aircraft_model VARCHAR(50) NOT NULL,
                           total_seats INT NOT NULL CHECK ( total_seats > 0 )
);

-- DROP TABLE Flights;
CREATE TABLE flights (
                         flight_id INT PRIMARY KEY AUTO_INCREMENT,
                         flight_number VARCHAR(10),
                         aircraft_id INT,
                         flight_mileage INT NOT NULL CHECK ( flight_mileage > 0 ),
                         FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
);

-- DROP TABLE bookings;
CREATE TABLE bookings (
                          booking_id INT PRIMARY KEY AUTO_INCREMENT,
                          customer_id INT NOT NULL,
                          flight_id INT NOT NULL,
                          FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                          FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
                          UNIQUE (customer_id, flight_id)
);

-- Creating Indexes for imnproved join performance
CREATE INDEX idx_flights_aircraft ON Flights(aircraft_id);
CREATE INDEX idx_bookings_customer ON Bookings(customer_id);
CREATE INDEX idx_bookings_flight ON Bookings(flight_id);



INSERT INTO customers (customer_id, customer_name, customer_status, total_customer_mileage) VALUES
                                                                                                (1, 'Agustine Riviera', 'Silver', 115235),
                                                                                                (2, 'Alaina Sepulvida', 'None', 6008),
                                                                                                (3, 'Tom Jones', 'Gold', 205767),
                                                                                                (4, 'Sam Rio', 'None', 2653),
                                                                                                (5, 'Jessica James', 'Silver', 127656),
                                                                                                (6, 'Ana Janco', 'Silver', 136773),
                                                                                                (7, 'Jennifer Cortez', 'Gold', 300582),
                                                                                                (8, 'Christian Janco', 'Silver', 14642);


INSERT INTO aircrafts (aircraft_id, aircraft_model, total_seats) VALUES
                                                                     (1, 'Boeing 747', 400),
                                                                     (2, 'Airbus A330', 236),
                                                                     (3, 'Boeing 777', 264);


INSERT INTO flights (flight_id, flight_number, aircraft_id, flight_mileage) VALUES
                                                                                (1, 'DL143', 1, 135),
                                                                                (2, 'DL122', 2, 4370),
                                                                                (3, 'DL53', 3, 2078),
                                                                                (4, 'DL222', 3, 1765),
                                                                                (5, 'DL37', 1, 531);

INSERT INTO bookings (booking_id, customer_id, flight_id) VALUES
                                                              (1, 1, 1),
                                                              (2, 1, 2),
                                                              (3, 2, 2),
                                                              (4, 3, 2),
                                                              (5, 3, 3),
                                                              (6, 3, 4),
                                                              (7, 4, 1),
                                                              (8, 4, 5),
                                                              (9, 5, 1),
                                                              (10, 5, 2),
                                                              (11, 6, 4),
                                                              (12, 7, 4),
                                                              (13, 8, 4);


SELECT COUNT(DISTINCT flight_number) FROM flights;
-- Answer: 5

SELECT AVG(flight_mileage) FROM flights;
-- Answer: 1775.8000

SELECT AVG(total_seats) FROM aircrafts;
-- Answer: 300.0000

SELECT customer_status, AVG(total_customer_mileage) AS avg_mileage
FROM Customers
GROUP BY customer_status;
-- Answer: Silver - 98576.5000, None - 4330.5000, Gold - 253174.5000

SELECT customer_status, MAX(total_customer_mileage) as max_mileage
FROM Customers
GROUP BY customer_status;
-- Answer: Silver - 136773, None - 6008, Gold - 300582

SELECT COUNT(*) FROM aircrafts WHERE aircraft_model LIKE '%Boeing%';
-- Answer: 2

SELECT * FROM flights WHERE flight_mileage BETWEEN 300 AND 2000;

SELECT c.customer_status, AVG(f.flight_mileage)
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_id = f.flight_id
GROUP BY c.customer_status;
-- Answer: Silver - 2090.0000, None - 1678.6667, Gold - 2494.5000

SELECT a.aircraft_model, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_id = f.flight_id
         JOIN aircrafts a ON f.aircraft_id = a.aircraft_id
WHERE c.customer_status = 'Gold'
GROUP BY a.aircraft_model
ORDER BY total_bookings DESC
LIMIT 1;
-- Answer: Boeing 777 - 3


