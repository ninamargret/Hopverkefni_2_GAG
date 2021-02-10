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
BEGIN;
INSERT INTO Professions
VALUES
(10002, 'Bla therapist');
INSERT INTO People 
VALUES
(10001, 'Harpa Steingrimsdottir', 10002, 2, 26);
INSERT INTO InvolvedIn
VALUES
(10001, 1, 1, TRUE);



SELECT P.PersonID, P.name, Pr.description AS profession_description, COUNT(I.CaseID) AS numcases
FROM Professions Pr
JOIN People P ON P.ProfessionID = Pr.ProfessionID
JOIN InvolvedIN I ON P.PersonID = I.PersonID
JOIN Cases C ON I.CaseID = C.CaseID
WHERE Pr.description LIKE '% therapist' AND C.isClosed = FALSE
GROUP BY P.PersonID, Pr.description;
ROLLBACK;

select 9 as Query;

-- The ID and name of each person involved in at least two cases
-- in a town whose name ends in "vogur". Additionally, a row called
-- "hasbeenculprit" should say "guilty" if they have ever been the
-- culprit in any of those cases, otherwise it should say "not guilty"

SELECT P.PersonID, P.name, CASE WHEN bool_or(I.isCulprit) THEN 'guilty' ELSE 'not_guilty' END AS "hasbeenculprit"
FROM People P 
JOIN InvolvedIn I ON P.PersonID = I.PersonID
JOIN Cases C ON C.CaseID = I.CaseID
JOIN Locations L ON L.LocationID = C.LocationID
WHERE L.location LIKE '%vogur'
GROUP BY P.PersonID
HAVING COUNT(I.PersonID) >= 2;

