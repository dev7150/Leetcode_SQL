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

-- 175. Combine Two Tables
Select firstName,
lastName,
city,
state
from Person p
left join Address a
on p.personId = a.personId

-- 1581. Customer Who Visited but Did Not Make Any Transactions
Select customer_id,count(v.visit_id) as count_no_trans
from Visits v
left join Transactions t
on v.visit_id = t.visit_id
where t.visit_id is null
group by 1

-- 1148. Article Views I
select distinct(author_id) as id
from Views
where author_id = viewer_id
order by author_id

-- 197. Rising Temperature
Select w1.id
from Weather w1
join Weather w2
on datediff(w1.recordDate, w2.recordDate) = 1
 and w1.temperature > w2.temperature

--  607. Sales Person
Select sp.name 
from SalesPerson sp
left join Orders o
on o.sales_id = sp.sales_id
left join Company c
on c.com_id = o.com_id
group by sp.sales_id
having sum(c.name="RED")=0 or sum(c.name is null)>0

--1741. Find Total Time Spent by Each Employee
select
    event_day as day,
    emp_id,
    sum(out_time - in_time) as total_time
from
    Employees
group by
    event_day,
    emp_id;


--1141. User Activity for the Past 30 Days I
Select activity_date as day,
count(distinct user_id) as active_users
from Activity
where datediff('2019-07-27',activity_date) < 30 
and activity_date < '2019-07-27'
group by activity_date

--1693. Daily Leads and Partners
Select date_id,
make_name,
count(distinct lead_id) as unique_leads,
count(distinct partner_id) as unique_partners
from DailySales
group by 1,2

-- 1729. Find Followers Count
Select user_id,
count(follower_id) as followers_count
from Followers
where user_id <> follower_id
group by 1
order by 1

-- 586. Customer Placing the Largest Number of Orders
Select customer_number
from Orders
group by customer_number
order by count(order_number) desc
limit 1


-- 511. Game Play Analysis I
(Select player_id, rank() over (partition by player_id order by event_date) as rnk,
event_date
from Activity
group by 1,3
)
Select player_id, event_date as first_login
from base 
where rnk = 1

select
player_id,
min(event_date) as first_login
from activity
group by player_id

-- 1890. The Latest Login in 2020
Select user_id,
max(time_stamp) as last_stamp
from Logins
where time_stamp like '2020%'
group by 1

Select user_id,
max(time_stamp) as last_stamp
from Logins
where EXTRACT(YEAR FROM time_stamp) = 2020
group by 1;

-- 1393. Capital Gain/Loss
with base as(Select stock_name, 
case when operation = "Sell" then price else (-1)*price end as p,
operation_day
from Stocks
order by 1,3 )

Select stock_name, sum(p) as capital_gain_loss
from base
group by 1

-- 1407. Top Travellers
Select name, travelled_distance from
(Select u.id,name, coalesce(sum(distance),0) as travelled_distance
from Users u
left join Rides r
on u.id = r.user_id
group by 1)z
order by 2 desc,1 asc

-- 1158. Market Analysis I
Select u.user_id as buyer_id, u.join_date,coalesce(count(order_id),0) as orders_in_2019
from Users u
left join Orders o
on u.user_id = o.buyer_id
and extract(year from order_date) =  2019 --if where used then it does not join at all
group by 1,2

-- 182. Duplicate Emails
Select email 
from Person
group by 1
having count(email) > 1

-- 1050. Actors and Directors Who Cooperated At Least Three Times
Select actor_id,
director_id
from ActorDirector
group by 1,2
having count(*) > 2
