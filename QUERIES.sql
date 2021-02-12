select
    1 as Query;

SELECT
    locationid AS "Location ID",
    location AS "Location name"
FROM
    locations
ORDER BY
    location DESC;


select
    2 as Query;

SELECT
    location AS "Locations with at least one case"
FROM
    Locations
WHERE
    caseCount >= 1
ORDER BY
    location ASC;


select
    3 as Query;

SELECT
    COUNT(G.gender) AS "Amount of females in database"
FROM
    people P
    NATURAL JOIN Genders G
WHERE
    G.gender = 'Female';


select
    4 as Query;

SELECT
    P.name AS "Secret identity name of agents"
FROM
    Agents A
    JOIN People P ON A.secretIdentity = P.PersonID
    JOIN InvolvedIn I ON A.AgentID = I.AgentID
GROUP BY
    A.AgentID,
    P.PersonID
HAVING
    COUNT(I.PersonID) > 10
    and A.secretIdentity = P.PersonID;


select
    5 as Query;

SELECT
    P.PersonID AS "Person ID",
    P.name AS "Name of Person",
    C.title AS "Case title"
FROM
    involvedin I
    JOIN people P ON P.PersonID = I.PersonID
    JOIN cases C ON I.CaseID = C.CaseID
WHERE
    I.isculprit = TRUE
    AND P.LocationID = C.LocationID;


select
    6 as Query;

SELECT
    DISTINCT P.PersonID AS "Person ID",
    P.name AS "Name of person",
    G.gender
FROM
    Genders G
    JOIN People P ON G.GenderID = P.GenderID
    JOIN InvolvedIn I ON I.PersonID = P.PersonID
    JOIN Cases C ON I.CaseID = C.CaseID
    JOIN Locations L ON L.LocationID = C.LocationID
WHERE
    L.location = 'Selfoss';


select
    7 as Query;

BEGIN;

INSERT INTO
    Professions
VALUES
    (10002, 'Bla therapist');

INSERT INTO
    People
VALUES
    (10001, 'Harpa Steingrimsdottir', 10002, 2, 26);

INSERT INTO
    InvolvedIn
VALUES
    (10001, 1, 1, TRUE);

SELECT
    P.PersonID AS "Person ID",
    P.name AS "Name of person",
    Pr.description AS "Profession description",
    COUNT(I.CaseID) AS "numcases"
FROM
    Professions Pr
    JOIN People P ON P.ProfessionID = Pr.ProfessionID
    JOIN InvolvedIN I ON P.PersonID = I.PersonID
    JOIN Cases C ON I.CaseID = C.CaseID
WHERE
    Pr.description LIKE '% therapist'
    AND C.isClosed = FALSE
GROUP BY
    P.PersonID,
    Pr.description;

ROLLBACK;


select
    8 as Query;

SELECT
    A.codename AS "Codename of an Agent",
    G.gender AS "Gender of agent",
    P.Password AS "Agents password"
FROM
    Passwords P
    JOIN Agents A ON P.AgentID = A.AgentID
    JOIN Genders G ON G.GenderID = A.GenderID
WHERE
    P.Password LIKE concat('%', A.codename, '%');


select
    9 as Query;

SELECT
    P.PersonID AS "Person ID",
    P.name AS "Name of person",
    CASE
        WHEN bool_or(I.isCulprit) THEN 'Guilty'
        ELSE 'Not guilty'
    END AS "Has been culprit"
FROM
    People P
    JOIN InvolvedIn I ON P.PersonID = I.PersonID
    JOIN Cases C ON C.CaseID = I.CaseID
    JOIN Locations L ON L.LocationID = C.LocationID
WHERE
    L.location LIKE '%vogur'
GROUP BY
    P.PersonID
HAVING
    COUNT(I.PersonID) >= 2;


select
    10 as Query;

SELECT
    P.PersonID AS "Person ID",
    P.name AS "Name of person",
    G.gender,
    (2045 - MAX(C.year)) AS "Years since Last Investigation"
FROM
    Genders G
    JOIN People P ON G.GenderID = P.GenderID
    JOIN InvolvedIn I ON I.PersonID = P.PersonID
    JOIN Cases C ON I.CaseID = C.CaseID
GROUP BY
    P.PersonID,
    G.GenderID
HAVING
    COUNT(DISTINCT I.AgentID) = 3;