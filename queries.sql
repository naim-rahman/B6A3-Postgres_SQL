CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50),
    phone VARCHAR(20),
    role VARCHAR(20) CHECK (role IN ('Admin', 'Customer')) NOT NULL
);



CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('Car', 'Bike', 'Truck')) NOT NULL,
    model VARCHAR(50) NOT NULL,
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    rental_price NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Available', 'Rented', 'Maintenance')) NOT NULL
);



CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    vehicle_id INT REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')) NOT NULL,
    total_cost NUMERIC(10,2) NOT NULL,
    CONSTRAINT validation_dates CHECK (end_date >= start_date)
);



-- Query-01
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status AS booking_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;



-- Query-02
SELECT
    v.vehicle_id,
    v.name,
    v.type,
    v.model,
    v.registration_number,
    ROUND(v.rental_price) AS rental_price,
    v.status
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
)
ORDER BY v.vehicle_id;


-- Query-03
SELECT
    vehicle_id,
    name,
    type,
    model,
    registration_number,
    rental_price,
    status
FROM vehicles
WHERE type = 'Car'
  AND status = 'Available';



-- Queries-04
SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;