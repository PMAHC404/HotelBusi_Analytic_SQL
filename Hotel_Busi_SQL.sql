-- DDL
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'occupied'))
);

CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY,
    room_id INT,
    customer_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Inserting data into the Rooms table
INSERT INTO Rooms (room_id, room_type, status) VALUES
(1, 'Deluxe', 'available'),
(2, 'Deluxe', 'available'),
(3, 'Executive Suite', 'available'),
(4, 'Presidential Suite', 'available'),
(5, 'Deluxe', 'occupied'),
(6, 'Presidential Suite', 'occupied'),
(7, 'Executive Suite', 'occupied'),
(8, 'Deluxe', 'available'),
(9, 'Presidential Suite', 'available');

-- Inserting data into the Reservations table
INSERT INTO Reservations (reservation_id, room_id, customer_id, check_in_date, check_out_date, amount_paid) VALUES
(1, 1, 101, '2024-02-01', '2024-02-05', 500),
(2, 2, 102, '2024-02-02', '2024-02-07', 800),
(3, 3, 103, '2024-02-03', '2024-02-10', 1200),
(4, 4, 104, '2024-02-04', '2024-02-06', 1000),
(5, 5, 105, '2024-02-05', '2024-02-09', 1500),
(6, 6, 106, '2024-02-06', '2024-02-08', 2000),
(7, 7, 107, '2024-02-07', '2024-02-11', 1800),
(8, 8, 108, '2024-02-08', '2024-02-12', 1600),
(9, 9, 109, '2024-02-09', '2024-02-13', 1400);

.print #######################
.print #### SQL Challenge ####
.print #######################

.print \n Rooms table
.mode box
select * from Rooms limit 5;

.print \n Reservations table
.mode box
select * from Reservations limit 5;


-- Query data about room type and number of available rooms for each type
select
  room_type,
  count(status) as available_room
from rooms
where status = 'available'
group by room_type;


-- Calculate average spending from customer
select
  avg(amount_paid) as avg_paid
from reservations;


-- Whose customers have highest spending of all time and total spend?
select
  customer_id,
  SUM(amount_paid) as total_spend,
  count(*) as num_reserv
from reservations
group by customer_id
order by total_spend desc
limit 1;


--What day of week have highest reservation?
select
  strftime('%w', check_in_date) as day_of_week,
  count(*) as booking_nums
from reservations
group by day_of_week
order by booking_nums desc;


--Calculate occupancy rate of hotel
