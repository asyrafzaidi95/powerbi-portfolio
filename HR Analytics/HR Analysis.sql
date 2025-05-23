--Create a Join Table

SELECT 
FROM Absenteeism_at_work a
LEFT JOIN compensation c
ON a.id = c.id
LEFT JOIN Reasons r
ON a.Reason_for_absence = r.number;

--Find the healthiest

SELECT * 
FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index <25 AND 
Absenteeism_time_in_hours <(SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work);

--Compensation rate increase for non-smoker/ budget $983,221 so 68% increase per hour /$1,414.4 per year
SELECT COUNT (*) AS nonsmokers
FROM Absenteeism_at_work
WHERE Social_smoker = 0

--Optimize thie query

SELECT
a.ID,
r.Reason,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	 WHEN Body_mass_index BETWEEN 18.5 AND 24.9 THEN 'Normal'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
INTO HR_Analytics
FROM Absenteeism_at_work a
LEFT JOIN compensation c
ON a.id = c.id
LEFT JOIN Reasons r
ON a.Reason_for_absence = r.number;

SELECT *
FROM HR_Analytics
WHERE Season_Names <> 'Unknown'


