select 1 as Query;
-- The ID and name of all locations, sorted descending by name

SELECT locationid AS "Location ID", location AS "Location name"
FROM locations
ORDER BY location DESC;

select 2 as Query;
-- The name of all locations with at least one case, sorted in ascending order.

SELECT location AS "Locations with at least one case"
FROM  Locations
WHERE caseCount >= 1
ORDER BY location ASC;

select 3 as Query;
-- The number of people that are female.

SELECT COUNT(G.gender) AS "Amount of females in database"
FROM people P JOIN Genders G ON P.GenderID = G.GenderID
WHERE G.gender = 'Female';

select 4 as Query;
-- The secret identity name of agents who have investigated people more than ten times

SELECT P.name AS "Secret identity name of agents"
FROM Agents A 
JOIN People P 
    ON A.secretIdentity = P.PersonID
JOIN InvolvedIn I 
    ON A.AgentID = I.AgentID
GROUP BY A.AgentID, P.PersonID    
HAVING COUNT(I.PersonID) > 10 and A.secretIdentity = P.PersonID;

select 5 as Query;
-- The PersonID, name, and case title of culprits that live 
-- in the same place they committed their crime

SELECT P.PersonID AS "Person ID", P.name AS "Name of Person", C.title AS "Case title"
FROM involvedin I
JOIN people P ON P.PersonID = I.PersonID
JOIN cases C ON I.CaseID = C.CaseID
WHERE I.isculprit = TRUE AND P.LocationID = C.LocationID;

select 6 as Query;
-- The ID, name and gender of all people who are involved in a case in Selfoss.

SELECT DISTINCT P.PersonID AS "Person ID", P.name AS "Name of person", G.gender AS "Gender of person"
FROM Genders G 
JOIN People P 
    ON G.GenderID = P.GenderID
JOIN InvolvedIn I 
    ON I.PersonID = P.PersonID
JOIN Cases C
    ON I.CaseID = C.CaseID
JOIN Locations L 
    ON L.LocationID = C.LocationID
WHERE L.location = 'Selfoss';

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


SELECT P.PersonID AS "Person ID", P.name AS "Name of person", Pr.description AS "Profession description", COUNT(I.CaseID) AS "numcases"
FROM Professions Pr
JOIN People P ON P.ProfessionID = Pr.ProfessionID
JOIN InvolvedIN I ON P.PersonID = I.PersonID
JOIN Cases C ON I.CaseID = C.CaseID
WHERE Pr.description LIKE '% therapist' AND C.isClosed = FALSE
GROUP BY P.PersonID, Pr.description;
ROLLBACK;

select 8 as Query;
-- The codename, gender and password of all agents that	have a weak password. 
-- A password is weak if the agent's codename can be	found in their password

SELECT A.codename AS "Codename of an Agent", G.gender AS "Gender of agent", P.Password AS "Agents password"
FROM Passwords P
JOIN Agents A 
    ON P.AgentID = A.AgentID
JOIN Genders G
    ON G.GenderID = A.GenderID
WHERE P.Password LIKE concat('%', A.codename, '%');

select 9 as Query;
-- The ID and name of each person involved in at least two cases
-- in a town whose name ends in "vogur". Additionally, a row called
-- "hasbeenculprit" should say "guilty" if they have ever been the
-- culprit in any of those cases, otherwise it should say "not guilty"

SELECT P.PersonID AS "Person ID", P.name AS "Name of person", CASE WHEN bool_or(I.isCulprit) THEN 'Guilty' ELSE 'Not guilty' END AS "Has been culprit"
FROM People P 
JOIN InvolvedIn I ON P.PersonID = I.PersonID
JOIN Cases C ON C.CaseID = I.CaseID
JOIN Locations L ON L.LocationID = C.LocationID
WHERE L.location LIKE '%vogur'
GROUP BY P.PersonID
HAVING COUNT(I.PersonID) >= 2;

select 10 as Query;
-- For people that have	been investigated by exactly 3 different agents, 
-- select their ID, name and gender as well as how  many years it has been since they were last investigated. 
-- The last column should be named “yearsSinceLastInvestigation” 
-- Please note that some people	involved in a crime are not investigated, and that The Bureau is operating in the current year: 2045.

SELECT P.PersonID AS "Person ID", P.name AS "Name of person", G.gender, (2045 - MAX(C.year)) AS "Years since Last Investigation"
FROM Genders G 
JOIN People P 
    ON G.GenderID = P.GenderID
JOIN InvolvedIn I 
    ON I.PersonID = P.PersonID
JOIN Cases C
    ON I.CaseID = C.CaseID
GROUP BY P.PersonID, G.GenderID
HAVING COUNT( DISTINCT I.AgentID) = 3;












