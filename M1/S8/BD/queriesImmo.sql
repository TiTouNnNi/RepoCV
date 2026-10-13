ALTER TABLE Appart ADD Loyer integer CONSTRAINT LoyerMustBePositive CHECK (Loyer > 0);

insert into Personne values ('David', null, 'Cadre');

SELECT NomImmeuble, AVG(Superficie) as SuperficieMoyenne FROM Appart GROUP BY NomImmeuble HAVING COUNT(NoAppart) > 3;

SELECT NomImmeuble, AVG(Superficie) as SuperficieMoyenne FROM APPART GROUP BY NomImmeuble HAVING AVG(Superficie) > (SELECT AVG(Superficie) as SuperficieMoyenne FROM Appart GROUP BY NomImmeuble HAVING NomImmeuble='Koudalou');

SELECT NomImmeuble , COUNT(NomImmeuble) as nbAppTotal FROM Appart GROUP BY NomImmeuble;

SELECT NomImmeuble FROM Appart GROUP BY NomImmeuble HAVING COUNT(NoAppart) = ( SELECT COUNT(NoAppart) from Occupant WHERE Occupant.NomImmeuble = Appart.NomImmeuble );

SELECT o1.NomOccupant, o2.NomOccupant, o1.NomImmeuble FROM Occupant o1 JOIN Occupant o2 ON o1.NomImmeuble = o2.NomImmeuble WHERE o1.nomoccupant < o2.nomoccupant;

SELECT Nom, MAX(Superficie) FROM Personne NATURAL JOIN Appart NATURAL JOIN Immeuble WHERE Immeuble.NomGerant = Personne.Nom GROUP BY Nom;

CREATE VIEW AppartGerant AS SELECT NoAppart, NomImmeuble, NomGerant FROM Appart NATURAL JOIN Immeuble;  
