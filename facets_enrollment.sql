-- Facets Enrollment Mock by Marla Morales
-- Purpose: Audit enrollment data to flag waste/fraud, like Medicare test scams, for DOGE efficiency cuts

-- Step 1: Create table to mimic CareSource Facets enrollment data
CREATE TABLE facets_enrollment (
    member_id INT,              -- Unique member identifier
    member_name VARCHAR(50),    -- Member's name
    plan_type VARCHAR(20),      -- HMO or PPO plan
    enrollment_date VARCHAR(10),-- Enrollment date in 'YYYY-MM-DD'
    status VARCHAR(10),         -- 'Active', 'Inactive', 'Pending'
    monthly_cost DECIMAL(10,2)  -- Monthly plan cost in dollars
);

-- Step 2: Insert mock data—active plans vs. suspect waste (high-cost inactive/pending, old dates)
INSERT INTO facets_enrollment (member_id, member_name, plan_type, enrollment_date, status, monthly_cost)
VALUES
    (1, 'John Doe', 'HMO', '2024-01-15', 'Active', 250.00),   -- Normal active plan
    (2, 'Jane Smith', 'PPO', '2024-02-01', 'Inactive', 300.00),-- Inactive, low cost
    (3, 'Mike Jones', 'HMO', '2023-12-10', 'Pending', 500.00), -- Suspect: high cost, old pending
    (4, 'Lisa Brown', 'PPO', '2024-03-01', 'Active', 275.00),  -- Normal active plan
    (5, 'Tom Lee', 'HMO', '2022-06-15', 'Inactive', 450.00),  -- Suspect: high cost, inactive
    (6, 'Sara White', 'PPO', '2024-01-20', 'Active', 260.00); -- Normal active plan

-- Step 3: Query to flag waste—high-cost inactive/pending or old costly plans
SELECT member_id, member_name, plan_type, enrollment_date, status, monthly_cost
FROM facets_enrollment
WHERE (status IN ('Inactive', 'Pending') AND monthly_cost > 400) -- Catch big fraud/waste
   OR (enrollment_date < '2024-01-01' AND monthly_cost > 300)   -- Catch old bleeders
ORDER BY monthly_cost DESC;                                      -- Worst offenders first

-- Result: Caught $950/mo waste—$500 pending (old), $450 inactive (costly)