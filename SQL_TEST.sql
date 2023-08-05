-- SQL TEST  --
-- data base create 
create database soccerdb;
-- user data base 
use soccerdb;

# 1. From the following table, write a SQL query to count the number of countries that parƟcipated
-- in the 2016-EURO Cup.
-- use table player_mast 
Select * from player_mast;

# 2. From the following table, write a SQL query to find the number of matches that ended with a
# result.
-- use table match_mast
select * from match_mast;
SELECT COUNT(*)
FROM match_mast
WHERE results IS NOT NULL;

# 3. From the following table, write a SQL query to find out when the Football EURO cup 2016 will
-- begin.
-- use table match_mast
select * from match_mast;
select * from soccer_venue;

SELECT MIN(play_date) AS start_date
FROM match_mast
WHERE tournament = 'EURO' AND EXTRACT(YEAR FROM play_date) = 2016;

# 4. From the following table, write a SQL query to find out where the final match of the EURO cup
-- 2016 was played.
-- Return venue name, city.
-- use tables: soccer_venue, soccer_city, match_mast

SELECT sv.venue_name, sc.city
FROM match_mast mm
JOIN soccer_venue sv ON mm.venue_id = sv.venue_id
JOIN soccer_city sc ON sv.city_id = sc.city_id
WHERE mm.match_type = 'Final';

# 5. From the following tables, write a SQL query to find the number of goals scored by each team in
-- each match during normal play.
-- Return match number, country name and goal score.
-- use tables: match_details, soccer_country
Select * from match_details;

# 6. From the following table, write a SQL query to count the number of goals scored by each player
-- within a normal play schedule. 
select * from goal_details;

SELECT player_id, COUNT(goal_id) AS number_of_goals
FROM goal_details
WHERE goal_schedule = 'NT'
GROUP BY player_id;

# 7. From the following table, write a SQL query to find out who scored the most goals in the 2016
-- Euro Cup.
-- Return player name, country name and highest individual scorer.
-- use tables: goal_details, player_mast, soccer_country
select * from player_mast;
SELECT pm.player_name AS player_name,
       COUNT(gd.goal_id) AS number_of_goals
FROM goal_details gd
JOIN player_mast pm ON gd.player_id = pm.player_id
WHERE EXTRACT(YEAR FROM gd.match_date) = 2016
GROUP BY pm.player_name, sc.country_name
ORDER BY number_of_goals DESC
LIMIT 1;

# 8. From the following table, write a SQL query to find out which teams played the first match of the
-- 2016 Euro Cup.
-- Return match number, country name.
-- use tables match_details, soccer_country
SELECT md.match_no AS match_number,
       sc.country_name AS country name
FROM match_details md
JOIN soccer_country as  sc ON md.home_team_id = home_team.country_id
J
    SELECT MIN(match_date)
    FROM match_details
    WHERE EXTRACT(YEAR FROM match_date) = 2016
);

# 9. From the following table, write a SQL query to find the highest audience match.
-- Return match_no, play_stage, goal_score, audience.
-- use table match_mast
select * from match_mast;

SELECT match_no, play_stage, goal_score, audence
FROM match_mast
WHERE audence = (SELECT MAX(audence) FROM match_mast);

# 10. Write a SQL query to find the players who scored goals in each match.
-- Group the result set on match number, country name and player name.
-- Sort the result-set in ascending order by match number.
-- Return match number, country name, player name and number of goals.
-- use tables goal_details, soccer_country, player_mast 

select * from goal_details;

select gd.match_no as match_number, 
pm.player_name as player_name
from goal_details as gd
left join player_mast as pm
on gd.player_id = pm.player_id
group by gd.match_no
order by gd.match_no ASC;