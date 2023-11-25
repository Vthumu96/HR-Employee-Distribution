-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
 SELECT Gender,count(*) AS count
 FROM HR
 WHERE termdate = '0000-00-00'
 GROUP BY Gender;
 
-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race,Count(*) AS NUM
FROM HR
WHERE termdate = '0000-00-00'
GROUP BY race
ORDER BY NUM DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
 CASE
 WHEN Age >18 AND age <= 24 THEN '18-24'
 WHEN Age>25 AND age <=34 THEN '25-34'
 WHEN Age>35 AND age <= 44 THEN '35-44'
 WHEN Age>45 AND  Age<=54 THEN '45-54'
 WHEN Age>55 AND age<=64 THEN '55-64'
 ELSE '65+'
 END as Age_group,Gender,Count(*) AS Count
 FROM HR
 WHERE termdate = '0000-00-00'
 GROUP BY age_group,Gender
 Order By age_group,Gender;
   
-- 4. How many employees work at headquarters versus remote locations?

SELECT location,Gender,Count(*) AS Count
FROM HR
WHERE termdate = '0000-00-00'
Group By Location,Gender;

-- 5. What is the average length of employment for employees who have been terminated?

SELECT
ROUND(Avg(datediff(termdate,hire_date))/365,1) AS Avg_Empl_len
FROM HR
WHERE termdate <= curdate() and termdate !='0000-00-00'
ORDER BY Avg_empl_len DESC;

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department,Gender,Count(*) AS Count
FROM HR
WHERE termdate ='0000-00-00'
Group By department,gender
Order By Department;

-- 7. What is the distribution of job titles across the company?

SELECT Jobtitle,Count(*) AS COUNT
FROM HR
WHERE termdate = '0000-00-00'
Group By Jobtitle
ORDER BY COUNT DESC;

-- 8. Which department has the highest turnover rate?

SELECT Department,total_count,terminated_count,terminated_count/total_count AS term_rate
FROM (
SELECT department,Count(*) AS Total_count,
SUM(CASE WHEN termdate !='0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM HR
GROUP BY department) as SUBQUERY
ORDER BY term_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?

SELECT location_state,Count(*) AS COUNT
FROM HR
WHERE termdate ='0000-00-00'
Group By location_state
ORDER BY Count DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT
 YEAR,
 hires,
 termination,
 hires-termination As Net_change,
 Round((hires-termination)/hires*100 ,2) As net_percent
FROM (
SELECT 
YEAR(hire_date) AS YEAR,
Count(*) As Hires,
SUM(CASE WHEN termdate!=0000-00-00 AND termdate<=CURDATE() THEN
1 ELSE 0 END) AS termination
FROM HR
GROUP BY year(hire_date)
) AS SUBQUERY
ORDER BY YEAR ASC;


-- 11. What is the tenure distribution for each department?

SELECT department, Round(Avg(Datediff(termdate,Hire_date)/365),0) AS tenure
From HR
WHERE Termdate <= current_date() AND termdate != 0000-00-00
GROUP BY Department;