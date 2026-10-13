-- Retrieves the 5 most populated communes in the Creuse department.
-- Uses the most recent available population data for each commune.
SELECT
  c.libelle AS commune_name,
  v.valeur AS population
FROM communes AS c
INNER JOIN departements AS d
  ON c.idd = d.idd
INNER JOIN valstat AS v
  ON c.idc = v.idc
INNER JOIN libellestat AS l
  ON v.idl = l.idl
WHERE
  d.libelle = 'Creuse'
  AND l.libelle = 'Population'
  AND v.AnneDebut = (
    SELECT
      MAX(AnneDebut)
    FROM valstat AS v2
    WHERE
      v2.idc = v.idc
      AND v2.idl = l.idl
  )
ORDER BY
  population DESC
LIMIT 5;

SELECT valstat.valeur, departements.libelle FROM communes inner join departements on departements.idd = communes.idd inner join valstat ON valstat.idc = communes.idc inner join libellestat on libellestat.idl = valstat.idl WHERE libellestat.libelle ='Population' AND valstat.anneDebut = 2022 OR valstat.anneDebut = 1990;