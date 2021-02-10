select 1 as Query;

-- The ID and name of all locations, sorted descending by name
SELECT locationid, location
FROM locations
ORDER BY location DESC;

select 3 as Query;

-- The number of people that are female.
SELECT COUNT(G.gender)
FROM people P JOIN Genders G ON P.GenderID = G.GenderID
WHERE G.gender = 'Female';


select 5 as Query;

-- The PersonID, name, and case title of culprits that live 
-- in the same place they committed their crime
SELECT P.PersonID, P.name, C.title
FROM involvedin I
JOIN people P ON P.PersonID = I.PersonID
JOIN cases C ON I.CaseID = C.CaseID
WHERE I.isculprit = TRUE AND P.LocationID = C.LocationID;

select 7 as Query;

-- For each Person that has a profession that ends with "therapist" and is involved
-- with an open case, list the ID, name and profession of the person and how many
-- open cases they are involved in; the last column should be named "numcases"
SELECT P.PersonID, P.name, Pr.description, COUNT(I.CaseID) AS numcases
FROM People P
NATURAL JOIN Professions Pr
NATURAL JOIN InvolvedIN I
JOIN Cases C ON I.CaseID = C.CaseID
WHERE Pr.description LIKE '% therapist' AND C.isClosed = FALSE
GROUP BY P.PersonID, P.name, Pr.description

select 9 as Query;

-- select ...


