-- HEDIS Flu Shot Abstraction Demo by Marla Morales LPN
-- Purpose: As an LPN, I built this SQL project to track flu shot compliance across clinics,
-- identifying care gaps for HEDIS quality reporting.

-- Step 1: Create patient table for HEDIS data
CREATE TABLE patients (
    id INT,
    name VARCHAR(50),
    age INT,
    clinic VARCHAR(50),
    flu_shot_date VARCHAR(10) -- 'YYYY-MM-DD' or NULL if no shot
);

-- Step 2: Insert mock patient data with realistic nursing scenarios
INSERT INTO patients (id, name, age, clinic, flu_shot_date)
VALUES 
    (1, 'John Doe', 45, 'Downtown', '2024-10-15'),
    (2, 'Jane Smith', 72, 'Eastside', NULL),
    (3, 'Mary Johnson', 30, 'Downtown', '2024-11-01'),
    (4, 'Tom Brown', 65, 'Westside', NULL),
    (5, 'Lisa White', 28, 'Eastside', '2024-09-20'),
    (6, 'Juan Garcia', 22, 'Midtown', '2024-09-10'),
    (7, 'Jesse James', 78, 'Eastside', NULL),
    (8, 'Shirley Jones', 80, 'Middletown', '2024-11-27'),
    (9, 'Jeff Fritz', 5, 'Downtown', '2023-08-23'),
    (10, 'Lisa Burns', 17, 'Hillcountry', NULL),
    (11, 'Teri Weaver', 40, 'Eastside', '2024-10-22');

-- Step 3: HEDIS Queries for Quality Measures

-- Query 1: Patients 65+ without flu shots (senior compliance)
SELECT name, age, clinic
FROM patients
WHERE age >= 65 AND flu_shot_date IS NULL
ORDER BY age DESC;
-- Output: Jesse James (78, Eastside), Jane Smith (72, Eastside), Tom Brown (65, Westside)

-- Query 2: Clinics with most missing flu shots (gap analysis)
SELECT clinic, COUNT(*) AS no_shot_count
FROM patients
WHERE flu_shot_date IS NULL
GROUP BY clinic
ORDER BY no_shot_count DESC;
-- Output: Eastside (2), Westside (1), Hillcountry (1)

-- Query 3: Patients under 40 with flu shots (youth compliance)
SELECT TOP 3 name, age, clinic
FROM patients
WHERE age < 40 AND flu_shot_date IS NOT NULL
ORDER BY age ASC;
-- Output: Juan Garcia (22, Midtown), Lisa White (28, Eastside), Mary Johnson (30, Downtown)

-- Query 4: Patients with outdated or missing shots (compliance gaps)
SELECT TOP 2 name, age, clinic
FROM patients
WHERE flu_shot_date < '2024-01-01' OR flu_shot_date IS NULL
ORDER BY age ASC;
-- Output: Jeff Fritz (5, Downtown), Tom Brown (65, Westside)

-- Query 5: Recent flu shots (current season compliance, Sept 2024 onward)
SELECT TOP 3 name, age, clinic
FROM patients
WHERE flu_shot_date IS NOT NULL AND flu_shot_date >= '2024-09-01'
ORDER BY flu_shot_date ASC;
-- Output: Juan Garcia (22, Midtown), Lisa White (28, Eastside), John Doe (45, Downtown)