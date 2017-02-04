-- 1.1 How many airplanes have listed speeds?
SELECT COUNT(*) 
FROM flights.planes 
WHERE speed IS NOT NULL
-- '23'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_1.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.2 What is the minimum listed speed and the maximum listed speed?
SELECT MAX(speed) AS max_speed 
FROM flights.planes
-- '432'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_2.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.3
SELECT MIN(speed) AS min_speed 
FROM flights.planes
-- '90'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_3.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.4 What is the total distance flown by all of the planes in January 2013?
SELECT SUM(flights.distance) 
FROM flights.flights 
WHERE flights.year = '2013'
-- '350217607'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_4.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.5 What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
SELECT SUM(flights.distance)
FROM flights.flights
WHERE flights.year = '2013' AND flights.tailnum IS NULL
-- '1784167'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_5.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.6 What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
SELECT SUM(flights.distance)
FROM flights.flights
INNER JOIN flights.planes ON flights.tailnum = planes.tailnum
WHERE flights.year = '2013' AND flights.month = '7' AND flights.day = '5'
-- 'AIRBUS', '195089'
-- 'AIRBUS INDUSTRIE', '78786'
-- 'AMERICAN AIRCRAFT INC', '2199'
-- 'BARKER JACK L', '937'
-- 'BOEING', '335028'
-- 'BOMBARDIER INC', '31160'
-- 'CANADAIR', '1142'
-- 'CESSNA', '2898'
-- 'DOUGLAS', '1089'
-- 'EMBRAER', '77909'
-- 'GULFSTREAM AEROSPACE', '1157'
-- 'MCDONNELL DOUGLAS', '7486'
-- 'MCDONNELL DOUGLAS AIRCRAFT CO', '15690'
-- 'MCDONNELL DOUGLAS CORPORATION', '4767'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_6.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.7 LEFT JOIN adds NULL values for manufacturer
SELECT planes.manufacturer, SUM(flights.distance)
FROM flights.flights 
LEFT JOIN flights.planes ON flights.tailnum = planes.tailnum
WHERE flights.year = '2013' AND flights.month = '7' AND flights.day = '5'
GROUP BY planes.manufacturer
-- 'NULL', '127671'
-- 'AIRBUS', '195089'
-- 'AIRBUS INDUSTRIE', '78786'
-- 'AMERICAN AIRCRAFT INC', '2199'
-- 'BARKER JACK L', '937'
-- 'BOEING', '335028'
-- 'BOMBARDIER INC', '31160'
-- 'CANADAIR', '1142'
-- 'CESSNA', '2898'
-- 'DOUGLAS', '1089'
-- 'EMBRAER', '77909'
-- 'GULFSTREAM AEROSPACE', '1157'
-- 'MCDONNELL DOUGLAS', '7486'
-- 'MCDONNELL DOUGLAS AIRCRAFT CO', '15690'
-- 'MCDONNELL DOUGLAS CORPORATION', '4767'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_7.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- 1.8 Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.
-- select flights flown by Boeing in 2013 from Newark where visibility is 10
SELECT COUNT(*)
FROM flights.flights AS fl
LEFT JOIN flights.planes AS pl ON pl.tailnum = fl.tailnum
LEFT JOIN flights.weather AS we ON we.origin = fl.origin
WHERE fl.year = '2013'
AND fl.origin = 'JFK' 
AND pl.manufacturer = 'BOEING'
AND we.visib = '10'
-- '148812'
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/assignment_1_8.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
