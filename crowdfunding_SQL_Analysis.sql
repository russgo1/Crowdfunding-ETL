-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT cf_id, backers_count, outcome FROM campaign
WHERE outcome = 'live' 
ORDER BY backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT cf_id AS " Live Campaign ID",
	COUNT (backer_id) AS "Backers"
FROM backers
GROUP BY cf_id
ORDER BY "Backers" DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order.  

SELECT co.first_name,
	co.last_name,
	co.email,
	(cm.goal - cm.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts AS co
JOIN campaign AS cm
ON (co.contact_id = cm.contact_id)
WHERE cm.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email,
	b.first_name,
	b.last_name,
	cm.cf_id,
	cm.company_name,
	cm.description,
	cm.end_date,
	(cm.goal - cm.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS b
JOIN campaign AS cm
ON (b.cf_id = cm.cf_id)
WHERE cm.outcome = 'live'
ORDER BY b.last_name;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;

