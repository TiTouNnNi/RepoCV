-- Ces vues agrègent les populations (en supposant que le code de la statistique soit 'POP').


-- View for department population aggregated by year.
CREATE OR REPLACE VIEW v_population_departement_annee AS
SELECT 
    d.idDepartement,
    d.nomDepartement,
    EXTRACT(YEAR FROM s.dateFin) AS annee,
    SUM(s.valeur) AS population_totale
FROM Departement d
JOIN Commune c ON d.idDepartement = c.idDepartement
JOIN Statistique s ON c.idCommune = s.idCommune
JOIN StatType st ON s.idStatType = st.idStatType
WHERE st.codeStat = 'POP'
GROUP BY d.idDepartement, d.nomDepartement, EXTRACT(YEAR FROM s.dateFin);

-- View for region population aggregated by year, utilizing the previous view.
CREATE OR REPLACE VIEW v_population_region_annee AS
SELECT 
    r.idRegion,
    r.nomRegion,
    v.annee,
    SUM(v.population_totale) AS population_totale
FROM Region r
JOIN Departement d ON r.idRegion = d.idRegion
JOIN v_population_departement_annee v ON d.idDepartement = v.idDepartement
GROUP BY r.idRegion, r.nomRegion, v.annee;