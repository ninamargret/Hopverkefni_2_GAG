select 2 as Query;
-- The name of all locations with at least one case, sorted in ascending order.
SELECT location, caseCount
FROM  Locations
WHERE caseCount >= 1 --Er at least < eða >=??
ORDER BY location ASC, caseCount;

select 4 as Query;
-- The secret identity name of agents who have investigated people more than ten times
SELECT A.codename
FROM Agents A 
JOIN InvolvedIn I ON A.AgentID = I.AgentID
GROUP BY A.codename
HAVING COUNT(I.PersonID) > 10;


select 6 as Query;
-- The ID, name and gender of all people who are involved in a case in Selfoss.

SELECT P.PersonID, P.name, G.gender
FROM Genders G 
JOIN People P 
    ON G.GenderID = P.GenderID
JOIN InvolvedIn I 
    ON I.PersonID = P.PersonID
JOIN Cases C
    ON I.CaseID = C.CaseID
JOIN Locations L ON L.LocationID = C.LocationID
WHERE L.location = 'Selfoss';

select 8 as Query;
-- The codename, gender and password of all agents that	have a weak password. A	password is	weak if the agent's codename can be	found in their password
SELECT A.codename, G.gender, P.Password
FROM Passwords P
JOIN Agents A 
    ON P.AgentID = A.AgentID
JOIN Genders G
    ON G.GenderID = A.GenderID
WHERE P.Password = '%'+ A.codename+ '%'; -- HJÁLP


select 10 as Query;
-- For people that have	been investigated by exactly 3 different agents, 
-- select their ID, name and gender as well as how  many years it has been since they were last investigated. 
-- The last column should be named “yearsSinceLastInvestigation” 
-- Please note that some people	involved in a crime are not investigated, and that The Bureau is operating in the current year: 2045.

SELECT P.PersonID, P.name, G.gender, “yearsSinceLastInvestigation”
FROM Genders G 
JOIN People P 
    ON G.GenderID = P.GenderID
JOIN InvolvedIn I 
    ON I.PersonID = P.PersonID
JOIN Cases C
    ON I.CaseID = C.CaseID 


--HJÁLP hvernig reikna ég