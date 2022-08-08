USE ChicagoData;

-- Create a union table from 2021 crimes history and 2022 crimes history

CREATE TABLE IF NOT EXISTS CrimesAllData AS(
SELECT *
FROM Crimes_2021
UNION 
SELECT *
FROM Crimes_2022
);

-- rename some columns 

SELECT *
FROM CrimesAllData;

ALTER TABLE  CrimesAllData
RENAME COLUMN `Case Number` TO CaseNumber;

ALTER TABLE CrimesAllData
RENAME COLUMN `Primary Type` TO PrimaryType;

ALTER TABLE CrimesAllData
RENAME COLUMN `Location Description` TO LocationDescription;

ALTER TABLE CrimesAllData
RENAME COLUMN `Community Area` TO CommunityArea;

ALTER TABLE CrimesAllData
RENAME COLUMN `FBI Code` TO FBICode;

ALTER TABLE CrimesAllData
RENAME COLUMN `X Coordinate` TO XCordinate;

ALTER TABLE CrimesAllData
RENAME COLUMN `Y Coordinate` TO YCordinate;

ALTER TABLE CrimesAllData
RENAME COLUMN `Updated On` TO UpdatedOn;


-- Creating table with distinct values of description

CREATE TABLE IF NOT EXISTS DistinctCrimesType AS(

SELECT DISTINCT PrimaryType
FROM CrimesAllData

);

-- NOW I am going to get general idea about data


-- Check whether everything is alright

SELECT *
FROM DistinctCrimesType;

-- 202918 crimes was in 2021 year

SELECT COUNT(*)
FROM CrimesAllData
WHERE Year = 2021;

-- 116961 crimes was in 2022 year until the end of July

SELECT COUNT(*)
FROM CrimesAllData
WHERE Year = 2022;

-- Arrest was made in 39089 cases

SELECT COUNT(*)
FROM CrimesAllData
WHERE Arrest = 'True';

-- Arrest was made in 280790 cases

SELECT COUNT(*)
FROM CrimesAllData
WHERE Arrest = 'False';

SELECT COUNT(*)
FROM CrimesAllData;

SELECT *
FROM CrimesAllData
WHERE ID IS NULL 
OR CaseNumber IS NULL
OR Date IS NULL 
OR Block IS NULL
OR IUCR IS NULL
OR PrimaryType IS NULL 
OR Description IS NULL 
OR LocationDescription IS NULL 
OR Arrest IS NULL 
OR Domestic IS NULL 
OR Beat IS NULL
OR District IS NULL
OR Ward IS NULL
OR CommunityArea IS NULL
OR FBICode IS NULL 
OR XCordinate IS NULL
OR YCordinate IS NULL;



# DEMONSTRATE USING the most popular functional: GroupBy, HAVING, WINDOW functions


SELECT *
FROM CrimesAllData
LIMIT 10;

# SHOW TOP-5 most dangerous districts

SELECT District, COUNT(ID) AS CountOfCrimes
FROM CrimesAllData
GROUP BY District
ORDER BY CountOfCrimes DESC
LIMIT 5;


# SHOW TOP-10 most full of work police beats

SELECT Beat, COUNT(ID) AS CountOfCrimes
FROM CrimesAllData
GROUP BY Beat
ORDER BY CountOfCrimes DESC
LIMIT 10;


# SHOW types of crime having the count of crimes more than 5000

SELECT PrimaryType, COUNT(ID) AS CountOfCrimes
FROM CrimesAllData 
GROUP BY PrimaryType
HAVING COUNT(ID)  > 5000;

# For each beat in distict show count of crimtes using WINDOW functions

SELECT District,Beat,
       COUNT(ID) OVER (ORDER BY Beat) AS CountOfCrimes
FROM CrimesAllData;


# Create a VIEW

CREATE VIEW EachBeatInDistrictCrimes AS
SELECT District,Beat,
       COUNT(ID) OVER (ORDER BY Beat) AS CountOfCrimes
FROM CrimesAllData;

# TEST created VIEW

SELECT *
FROM EachBeatInDistrictCrimes;










