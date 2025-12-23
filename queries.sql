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




