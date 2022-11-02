-- 595. Big Countries
Select
    name,
    population,
    area
from
    World
where
    area >= 3000000
    or population >= 25000000;
    
-- 1757. Recyclable and Low Fat Products
Select
    product_id
from
    Products
where
    low_fats = 'Y'
    and recyclable = 'Y';

-- 584. Find Customer Referee
Select
    name
from
    Customer
where
    referee_id <> 2
    or referee_id is null

-- 183. Customers Who Never Order
Select name as Customers
from Customers c 
left join Orders o
on c.id = o.customerId
where o.customerId is null

-- 1873. Calculate Special Bonus
select employee_id , 
   case when employee_id%2 <>0 and name not like 'M%' then salary 
   else 0
   end 
   as bonus
   from employees
   order by employee_id;

-- 627. Swap Salary
UPDATE salary
SET sex= CASE 
         WHEN sex = 'f' THEN 'm'
         else 'f' end

-- 196. Delete Duplicate Emails
DELETE a.*
FROM Person a
JOIN Person b
ON a.email = b.email
where a.id > b.id

-- 1667. Fix Names in a Table
Select user_id,
concat(UPPER(LEFT(name, 1)) ,
        LOWER(RIGHT(name, LENGTH(name) - 1))) as name
from Users
order by 1

-- 1484. Group Sold Products By The Date
Select sell_date,
count(distinct product) as num_sold,
group_concat(distinct product) as products
from Activities
group by 1

-- 1527. Patients With a Condition
SELECT * FROM PATIENTS
WHERE conditions regexp '^DIAB1| DIAB1';

-- 1965. Employees With Missing Information
(SELECT E.employee_id
FROM Employees E
LEFT JOIN Salaries S on E.employee_id = S.employee_id
WHERE S.salary IS NULL
UNION
SELECT S.employee_id
FROM Employees E
RIGHT JOIN Salaries S on E.employee_id = S.employee_id
WHERE E.name IS NULL)
ORDER BY employee_id

-- 1795. Rearrange Products Table
SELECT product_id, 'store1' as store, store1 AS price FROM products
WHERE store1 IS NOT NULL
UNION
SELECT product_id, 'store2' as store, store2 AS price FROM products
WHERE store2 IS NOT NULL
UNION
SELECT product_id, 'store3' as store, store3 AS price FROM products
WHERE store3 IS NOT NULL

-- 608. Tree Node
select id, case when p_id is null then 'Root'
when id in (select p_id from tree) then 'Inner'
else 'Leaf' end as "Type"
from tree

-- 176. Second Highest Salary
SELECT max(salary) AS SecondHighestSalary
FROM Employee 
WHERE Salary <> (SELECT max(salary) FROM Employee)