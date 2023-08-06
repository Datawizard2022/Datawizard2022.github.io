Select * From public."male_players_legacy"
COPY Public."male_players_legacy" 
FROM 'C:\Data analytics Project\General Assembly\Data-sets\Capstone Project\FIFA 23\male_players (legacy).csv' DELIMITER ',' csv HEADER;


CREATE TABLE Public."male_players_legacy"( player_id INTEGER,
    player_url VARCHAR(255),
    fifa_version VARCHAR(50),
    fifa_update VARCHAR(50),
    fifa_update_date DATE,
    short_name VARCHAR(100),
    long_name VARCHAR(100),
    player_positions VARCHAR(100),
    overall INTEGER,
    potential INTEGER,
    value_eur INTEGER,
    wage_eur INTEGER,
    age INTEGER,
    dob DATE,
    height_cm INTEGER,
    weight_kg INTEGER,
    league_id INTEGER,
    league_name VARCHAR(100),
    league_level VARCHAR(50),
    club_team_id INTEGER,
    club_name VARCHAR(100),
    club_position VARCHAR(50),
    club_jersey_number INTEGER,
    club_loaned_from VARCHAR(100),
    club_joined_date DATE,
    club_contract_valid_until_year INTEGER,
    nationality_id INTEGER,
    nationality_name VARCHAR(100),
    nation_team_id INTEGER,
    nation_position VARCHAR(50),
    nation_jersey_number INTEGER,
    preferred_foot VARCHAR(10),
    weak_foot INTEGER,
    skill_moves INTEGER,
    international_reputation INTEGER,
    work_rate VARCHAR(50),
    body_type VARCHAR(50),
    real_face BOOLEAN,
    release_clause_eur INTEGER,
    player_tags VARCHAR(255),
    player_traits VARCHAR(255),
    pace INTEGER,
    shooting INTEGER,
    passing INTEGER,
    dribbling INTEGER,
    defending INTEGER,
    physic INTEGER,
    attacking_crossing INTEGER,
    attacking_finishing INTEGER,
    attacking_heading_accuracy INTEGER,
    attacking_short_passing INTEGER,
    attacking_volleys INTEGER,
    skill_dribbling INTEGER,
    skill_curve INTEGER,
    skill_fk_accuracy INTEGER,
    skill_long_passing INTEGER,
    skill_ball_control INTEGER,
    movement_acceleration INTEGER,
    movement_sprint_speed INTEGER,
    movement_agility INTEGER,
    movement_reactions INTEGER,
    movement_balance INTEGER,
    power_shot_power INTEGER,
    power_jumping INTEGER,
    power_stamina INTEGER,
    power_strength INTEGER,
    power_long_shots INTEGER,
    mentality_aggression INTEGER,
    mentality_interceptions INTEGER,
    mentality_positioning INTEGER,
    mentality_vision INTEGER,
    mentality_penalties INTEGER,
    mentality_composure INTEGER,
    defending_marking_awareness INTEGER,
    defending_standing_tackle INTEGER,
    defending_sliding_tackle INTEGER,
    goalkeeping_diving INTEGER,
    goalkeeping_handling INTEGER,
    goalkeeping_kicking INTEGER,
    goalkeeping_positioning INTEGER,
    goalkeeping_reflexes INTEGER,
    goalkeeping_speed INTEGER,
    ls VARCHAR(10),
    st VARCHAR(10),
    rs VARCHAR(10),
    lw VARCHAR(10),
    lf VARCHAR(10),
    cf VARCHAR(10),
    rf VARCHAR(10),
    rw VARCHAR(10),
    lam VARCHAR(10),
    cam VARCHAR(10),
    ram VARCHAR(10),
    lm VARCHAR(10),
    lcm VARCHAR(10),
    cm VARCHAR(10),
    rcm VARCHAR(10),
    rm VARCHAR(10),
    lwb VARCHAR(10),
    ldm VARCHAR(10),
    cdm VARCHAR(10),
    rdm VARCHAR(10),
    rwb VARCHAR(10),
    lb VARCHAR(10),
    lcb VARCHAR(10),
    cb VARCHAR(10),
    rcb VARCHAR(10),
    rb VARCHAR(10),
    gk VARCHAR(10),
    player_face_url VARCHAR(255)
);
SELECT short_name, overall, fifa_update_date
FROM public.male_players_legacy 
ORDER by Overall DESC;

SELECT short_name, potential, player_positions, fifa_update_date
FROM public.male_players_legacy    
ORDER BY fifa_update_date DESC

Select potential, short_name, fifa_update_date
FROM public.male_players_legacy 
Where potential = (select Max (potential)FROM public.male_players_legacy)

Select overall, short_name, fifa_update_date
FROM public.male_players_legacy 
Where overall = (select min (overall)FROM public.male_players_legacy)
--40 

Select overall, short_name, fifa_update_date
FROM public.male_players_legacy 
Where overall = (select min (overall)FROM public.male_players_legacy)
--40

40	"P. Tisdale"	"2014-09-18"
40	"P. Żemło"	"2014-09-18"
40	"T. Davies"	"2014-09-18"

Select overall, short_name, fifa_update_date
FROM public.male_players_legacy 
Where overall = (select max (overall)FROM public.male_players_legacy)
--MIN 40, Max 94

SELECT overall, short_name, fifa_update_date
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
ORDER BY overall DESC 

779 rows affected 

How many distinct names fall between this category. 

SELECT COUNT(DISTINCT short_name) AS distinct_count, overall
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
GROUP BY overall
ORDER BY overall DESC;

SELECT distinct player_id
FROM public.male_players_legacy 
Where short_name = 'L. Messi'

SELECT * 
FROM public.male_players_legacy 
Where player_id IN (SELECT distinct player_id
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94)

SELECT short_name, overall, fifa_update_date
FROM public.male_players_legacy 
ORDER by Overall DESC;

SELECT player_positions 
FROM public.male_players_legacy 
Where short_name = 'L. Messi'

SELECT player_positions, COUNT(player_positions) as position_count
FROM public.male_players_legacy
WHERE short_name = 'L. Messi'
GROUP BY player_positions
HAVING COUNT(player_positions) > 1

SELECT player_positions, COUNT(*) as position_count
FROM public.male_players_legacy
WHERE short_name = 'L. Messi'
GROUP BY player_positions
HAVING COUNT(*) > 1


SELECT
  CASE
    WHEN age >= 16 AND age < 20 THEN '16-19'
    WHEN age >= 20 AND age < 25 THEN '20-24'
    WHEN age >= 25 AND age < 30 THEN '25-29'
        ELSE 'Unknown'
  END AS age_group,
  skill_ball_control
FROM public.male_players_legacy


SELECT
  age_group,
  AVG(skill_ball_control) AS mean_ball_control_skill,
  STDDEV(skill_ball_control) AS std_dev_ball_control_skill
FROM (
  SELECT
    CASE
      WHEN age >= 16 AND age < 20 THEN '16-19'
      WHEN age >= 20 AND age < 25 THEN '20-24'
      WHEN age >= 25 AND age < 30 THEN '25-29'
	  WHEN age >= 30 AND age < 35 THEN '30-34'
	  WHEN age >= 35 AND age < 39 THEN '35-39'
           ELSE 'Unknown'
    END AS age_group,
    skill_ball_control
  FROM public.male_players_legacy
  ) AS age_group_stats
GROUP BY age_group

CREATE EXTENSION IF NOT EXISTS tablefunc;
SELECT *
FROM crosstab(
  'SELECT row_number() OVER () AS rowid, age_group, skill_ball_control
   FROM (
     SELECT
       CASE
         WHEN age BETWEEN 16 AND 19 THEN ''16-19''
         WHEN age BETWEEN 20 AND 24 THEN ''20-24''
         WHEN age BETWEEN 25 AND 29 THEN ''25-29''
         WHEN age BETWEEN 30 AND 34 THEN ''30-34''
         WHEN age BETWEEN 35 AND 39 THEN ''35-39''
         ELSE ''Unknown''
       END AS age_group,
       skill_ball_control
     FROM public.male_players_legacy
   ) AS subquery',
  'SELECT unnest(ARRAY[''16-19'', ''20-24'', ''25-29'', ''30-34'', ''35-39'', ''Unknown''])'
) AS ct(rowid int, "16-19" numeric, "20-24" numeric, "25-29" numeric, "30-34" numeric, "35-39" numeric, "Unknown" numeric)
ORDER BY rowid;


SELECT player_positions, COUNT(*) as position_count
FROM public.male_players_legacy
GROUP BY player_positions
HAVING COUNT(*) = (
  SELECT MAX(position_count)
  FROM (
    SELECT player_positions, COUNT(*) as position_count
    FROM public.male_players_legacy
    GROUP BY player_positions
  ) AS position_counts
)


SELECT player_positions, COUNT(*) as position_count
FROM public.male_players_legacy
WHERE short_name = 'L. Messi'
GROUP BY player_positions
HAVING COUNT(*) = (
  SELECT MAX(position_count)
  FROM (
    SELECT player_positions, COUNT(*) as position_count
    FROM public.male_players_legacy
	WHERE short_name = 'L. Messi'
    GROUP BY player_positions
  ) AS position_counts
)

Select overall, short_name, fifa_update_date
FROM public.male_players_legacy 
Where overall = (select max (overall between 94 and 40)FROM public.male_players_legacy)
--MIN 40, Max 94 

SELECT overall, Distinct count (short_name), fifa_update_date
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
ORDER BY overall DESC 
LIMIT 100;


SELECT distinct player_id
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
ORDER BY player_id DESC 


SELECT overall, COUNT(DISTINCT short_name) AS distinct_count, fifa_update_date, short_name
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
GROUP BY overall, fifa_update_date, short_name
ORDER BY overall DESC;

SELECT COUNT(DISTINCT short_name) AS distinct_count
FROM public.male_players_legacy
WHERE overall BETWEEN 85 AND 94
GROUP BY overall
ORDER BY overall DESC;

SELECT * 
FROM public.male_players_legacy
where short_name = (SELECT * FROM public.male_players_legacy) 

Select count (distinct player_id)
FROM public.male_players_legacy