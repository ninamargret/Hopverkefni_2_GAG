select 1 as Query;

-- The ID and name of all locations, sorted descending by name
SELECT locationid, location
FROM locations
ORDER BY location DESC;

select 3 as Query;

-- The number of people that are female.
SELECT count(genderid) AS num_of_female
FROM people p
WHERE p.genderid = 1;


select 5 as Query;

-- The PersonID, name, and case title of culprits that live 
-- in the same place they committed their crime
SELECT I.isculprit, I.personid, I.caseid
FROM involvedin I
WHERE I.isculprit = TRUE;

select 7 as Query;

-- select ...

select 9 as Query;

-- select ...


