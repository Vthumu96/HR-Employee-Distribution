SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN  ï»¿id EMP_ID VARCHAR(20)NULL;

SELECT birthdate FROM hr;

UPDATE HR
SET birthdate = CASE
WHEN Birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;
ALTER TABLE HR
MODIFY COLUMN birthdate DATE;
SELECT birthdate FROM hr;

SELECT hire_date FROM HR;

UPDATE HR
SET hire_date = CASE
WHEN Hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN hire_date DATE;
SELECT hire_date FROM HR;

UPDATE HR
SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate!= ' ';
SELECT termdate FROM HR;

ALTER TABLE HR
MODIFY COLUMN termdate DATE;

DESCRIBE HR;
ALTER TABLE HR
ADD COLUMN Age INT;

UPDATE HR
SET Age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT MIN(Age) AS YOUNGEST,MAX(AGE) AS OLDEST FROM HR;
SELECT Count(*) FROM HR
WHERE Age < 18;