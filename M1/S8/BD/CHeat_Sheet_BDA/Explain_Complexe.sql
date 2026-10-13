-- Complex query designed to generate a deeply nested execution plan.
-- It filters early (dates), aggregates data, joins 4 tables, and sorts the output.
EXPLAIN ANALYZE
SELECT 
    r.nomRegion, 
    d.nomDepartement, 
    COUNT(c.idCommune) AS nb_communes_analysees,
    AVG(s.valeur) AS moyenne_habitants
FROM Region r
JOIN Departement d ON r.idRegion = d.idRegion
JOIN Commune c ON d.idDepartement = c.idDepartement
JOIN Statistique s ON c.idCommune = s.idCommune
JOIN StatType st ON s.idStatType = st.idStatType
WHERE st.codeStat = 'POP'
  AND s.dateFin BETWEEN '2010-01-01' AND '2025-12-31'
  AND s.valeur > 1000  -- Forces early row filtering
GROUP BY r.nomRegion, d.nomDepartement
ORDER BY moyenne_habitants DESC, r.nomRegion ASC;