SELECT nomcommune, nbHabitants FROM Commune ORDER BY nbhabitants;

SELECT numDepot, dateDepot, poidsArrive, poidsDepart from DEPOT JOIN Commune ON DEPOT.codeCommune = Commune.codeCommune WHERE Commune.nomCommune = 'Lormont';

SELECT COUNT(*) AS nbDepot, nomCommune FROM DEPOT NATURAL JOIN Commune WHERE Commune.nomCommune = 'Lormont' AND DEPOT.dateDepot BETWEEN '2024-03-01' AND '2024-03-31' GROUP BY nomCommune;

 SELECT * from DEPOT JOIN TYPEDECHET ON TYPEDECHET.codeType = DEPOT.codeType WHERE TYPEDECHET.libelleType = 'plastique' AND DEPOT.numImmat = 'TB-555-PP' AND DEPOT.poidsDepart > 500 ORDER BY DEPOT.dateDepot DESC;
 
 SELECT * FROM CAMION NATURAL JOIN DEPOT NATURAL JOIN TYPEDECHET WHERE TYPEDECHET.libelleType = 'verre' AND DEPOT.dateDepot BETWEEN '2024-05-01' AND '2024-05-31';
 
SELECT DISTINCT nomCommune FROM COMMUNE NATURAL JOIN DEPOT JOIN TYPEDECHET ON TYPEDECHET.codeType = DEPOT.codeType WHERE TYPEDECHET.libelleType = 'verre' OR TYPEDECHET.libelleType = 'carton';

SELECT c1.nomCommune, SUM(d1.poidsArrive - d1.poidsDepart) as total FROM COMMUNE c1 JOIN DEPOT d1 ON d1.codeCommune = c1.codeCommune JOIN TYPEDECHET on TYPEDECHET.codeType = d1.codeType JOIN DEPOT d2 ON d2.codeType = TYPEDECHET.codeType JOIN COMMUNE c2 ON d2.codeCommune = c2.codeCommune WHERE TYPEDECHET.libelleType = 'carton' AND c2.nomCommune = 'Lormont' GROUP BY c1.codeCommune, c1.nomCommune HAVING SUM(d1.poidsArrive - d1.poidsDepart) < SUM(d2.poidsArrive - d2.poidsDepart);

SELECT * FROM CAMION NATURAL JOIN DEPOT NATURAL JOIN COMMUNE WHERE CAMION.nomProprietaire = 'Bordeaux Metropole' AND EXTRACT(YEAR from CAMION.miseEnService) > EXTRACT(YEAR FROM CURRENT_DATE)-10 AND COMMUNE.nomCommune = 'Talence';

SELECT DISTINCT libelleType, nomCommune FROM TYPEDECHET NATURAL JOIN DEPOT NATURAL JOIN COMMUNE WHERE COMMUNE.nomCommune = 'Lormont' OR Commune.nomCommune = 'Talence';

SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR from miseEnService)) as ageMoyen FROM CAMION;

SELECT SUM(poidsArrive - poidsDepart)as poidsTotal, libelleType FROM DEPOT NATURAL JOIN typeDechet GROUP BY libelleType;

SELECT numImmat, nomProprietaire, SUM(poidsArrive - poidsDepart) AS totalDepose FROM CAMION NATURAL JOIN DEPOT GROUP BY numImmat, nomProprietaire ORDER BY totalDepose DESC;

SELECT * FROM CAMION WHERE numImmat NOT IN ( SELECT numImmat from DEPOT);

SELECT CAMION.numImmat, COUNT(DISTINCT DEPOT.codeCommune) as nbCommune FROM CAMION NATURAL JOIN DEPOT GROUP BY CAMION.numImmat HAVING COUNT(DISTINCT DEPOT.codeCommune) = (SELECT COUNT(*) FROM COMMUNE);

CREATE VIEW poidsParCommune AS SELECT nomCommune, COALESCE(SUM(poidsArrive - poidsDepart),0) as poidsTotal FROM COMMUNE LEFT JOIN DEPOT ON DEPOT.codeCommune = COMMUNE.codeCommune GROUP BY nomCommune;

SELECT * FROM poidsParCommune ORDER BY poidsTotal DESC;

ALTER TABLE CAMION ADD miseEnRetraite DATE;

SELECT * FROM CAMION where miseEnRetraite IS NOT NULL;

SELECT * FROM CAMION where miseEnRetraite IS NULL;
