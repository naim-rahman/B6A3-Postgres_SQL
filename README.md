# 🚗 Vehicle Rental System – SQL Query Documentation

## 📌 Project Overview
This project contains a collection of structured SQL queries developed for a **Vehicle Rental System** using **PostgreSQL**.

The primary objective is to demonstrate a clear understanding of **relational database concepts** and the practical application of **SQL** to solve real-world business problems. All queries are written based on a predefined database schema and sample data.

---

## 📂 File Description

### `queries.sql`
The `queries.sql` file includes SQL queries designed to **retrieve, filter, and analyze data** related to vehicle rentals and bookings. Each query addresses a specific business requirement and is implemented using standard PostgreSQL features.

---

## 🧠 SQL Queries and Explanations

### 🔹 Query 1: Retrieve Booking Information Using INNER JOIN
**Objective:** Retrieve booking details along with the corresponding customer name and vehicle name.

```sql
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.booking_status AS status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;
```

## Concepts Used:

### INNER JOIN

Relational mapping between tables

---

### 🔹 Query 2: Identify Vehicles That Have Never Been Booked
Objective: Find vehicles that do not have any associated booking records.

```sql
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
```
## Concepts Used:

### NOT EXISTS

Subquery logic

---

###🔹 Query 3: Retrieve Available Vehicles of a Specific Type
Objective: Retrieve all vehicles that are currently available for rent and belong to a specific category (Car).

```sql
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
```
## Concepts Used:

### SELECT statement

WHERE clause filtering

---

### 🔹 Query 4: Retrieve Vehicles With More Than Two Bookings
Objective: Identify vehicles that have been booked more than two times.

```sql
SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
```
## Concepts Used:

### GROUP BY and HAVING

### Aggregate Functions (COUNT)

---

## ✅ Key Database Features
Primary and Foreign Key relationships: Ensures data integrity across tables.

Data validation: Uses CHECK constraints to ensure logical data entry.

Automatic cleanup: Implemented via ON DELETE CASCADE.

Business logic enforcement: Handled at the database level for better security and consistency.

---

* **ERD Diagram Link:** [https://drawsql.app/teams/naimur-rahman-1/diagrams/sql](https://drawsql.app/teams/naimur-rahman-1/diagrams/sql)
