![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# LAB | SQL Normalization, DDL & Aggregation

### Instructions

1. Fork this repo.
2. Clone your fork to your local machine.
3. Solve the challenges.


## Deliverables

- Upon completion, add your solution to git.
- Then commit to git and push to your repo on GitHub.
- Make a pull request and paste the pull request link in the submission field in the Student Portal.


## Exercise 1: Normalize a Blog Database

**Step 1:** Given the following raw dataset, identify redundancies and normalize the data (at least to 3NF).

<br>

| **author**          | **title**                       | **word_count** | **views** |
|----------------|-----------------------------|------------|-------|
| Maria Charlotte| Best Paint Colors           | 814        | 14    |
| Juan Perez     | Small Space Decorating Tips | 1146       | 221   |
| Maria Charlotte| Hot Accessories             | 986        | 105   |
| Maria Charlotte| Mixing Textures             | 765        | 22    |
| Juan Perez     | Kitchen Refresh             | 1242       | 307   |
| Maria Charlotte| Homemade Art Hacks          | 1002       | 193   |
| Gemma Alcocer  | Refinishing Wood Floors     | 1571       | 7542  |

<br>

**Step 2:** Write the DDL (`CREATE TABLE` statements) to implement your normalized schema.

**Step 3 (Optional):** Insert the sample data using `INSERT INTO`.

## Exercise 2: Normalize an Airline Database

**Step 1:** Normalize the following data (again, at least up to 3NF):

<br>

| **Customer Name**    | **Customer Status** | **Flight Number** | **Aircraft**    | **Total Aircraft Seats** | **Flight Mileage** | **Total Customer Mileage** |
| ---------------- | --------------- | ------------- | ----------- | -------------------- | -------------- | ---------------------- |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Agustine Riviera | Silver          | DL122         | Airbus A330 | 236                  | 4370           | 115235                 |
| Alaina Sepulvida | None            | DL122         | Airbus A330 | 236                  | 4370           | 6008                   |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Tom Jones        | Gold            | DL122         | Airbus A330 | 236                  | 4370           | 205767                 |
| Tom Jones        | Gold            | DL53          | Boeing 777  | 264                  | 2078           | 205767                 |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Sam Rio          | None            | DL143         | Boeing 747  | 400                  | 135            | 2653                   |
| Agustine Riviera | Silver          | DL143         | Boeing 747  | 400                  | 135            | 115235                 |
| Tom Jones        | Gold            | DL222         | Boeing 777  | 264                  | 1765           | 205767                 |
| Jessica James    | Silver          | DL143         | Boeing 747  | 400                  | 135            | 127656                 |
| Sam Rio          | None            | DL143         | Boeing 747  | 400                  | 135            | 2653                   |
| Ana Janco        | Silver          | DL222         | Boeing 777  | 264                  | 1765           | 136773                 |
| Jennifer Cortez  | Gold            | DL222         | Boeing 777  | 264                  | 1765           | 300582                 |
| Jessica James    | Silver          | DL122         | Airbus A330 | 236                  | 4370           | 127656                 |
| Sam Rio          | None            | DL37          | Boeing 747  | 400                  | 531            | 2653                   |
| Christian Janco  | Silver          | DL222         | Boeing 777  | 264                  | 1765           | 14642                  |

<br>

**Step 2:** Identify functional dependencies and decompose into smaller, related tables:
- `customers`
- `flights`
- `aircrafts`
- `bookings`

**Step 3:** Write the DDL scripts (`CREATE TABLE` + `FOREIGN KEY` constraints).

**Step 4:** Insert the sample data.

## Exercise 3: Write SQL Queries on the Airline Database

Use the schema you created in Exercise 2 to answer the following:

1. Total number of flights:
```sql
SELECT COUNT(DISTINCT flight_number) FROM flights;
```
2. Average flight distance:
```sql
SELECT AVG(mileage) FROM flights;
```
3. Average number of seats per aircraft:
```sql
SELECT AVG(total_seats) FROM aircrafts;
```
4. Average miles flown by customers, grouped by status:
```sql
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
```
5. Max miles flown by customers, grouped by status:
```sql
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
```
6. Number of aircrafts with "Boeing" in their name:
```sql
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';
```
7. Flights with distance between 300 and 2000 miles:
```sql
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;
```
8. Average flight distance **booked**, grouped by customer status:
```sql
SELECT c.status, AVG(f.mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;
```
9. Most booked aircraft among Gold status members:
```sql
SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_number = f.flight_number
JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;
```

## Extra Challenge

- Create `ERD` diagrams to visualize both schemas.
- Use `CHECK`, `NOT NULL`, and `UNIQUE` constraints where appropriate.
- Add indexes where you think performance can improve.

<br>

**Have fun querying!** :dart: