--Cette procédure recalcule la population de la région et du département à partir des statistiques les plus récentes.

-- Procedure to update the cached population in the Departement and Region tables.
-- It only calculates the sum based on the most recent census data for each commune.
CREATE OR REPLACE FUNCTION update_cached_populations()
RETURNS VOID AS $$
BEGIN
    -- Update Department population using a subquery that gets the latest stat per commune.
    UPDATE Departement d
    SET population = (
        SELECT SUM(latest_stats.valeur)
        FROM (
            SELECT s.valeur, c.idDepartement,
                   ROW_NUMBER() OVER(PARTITION BY s.idCommune ORDER BY s.dateFin DESC) as rn
            FROM Statistique s
            JOIN Commune c ON s.idCommune = c.idCommune
            JOIN StatType st ON s.idStatType = st.idStatType
            WHERE st.codeStat = 'POP'
        ) AS latest_stats
        WHERE latest_stats.rn = 1 AND latest_stats.idDepartement = d.idDepartement
    );

    -- Update Region population by summing up the newly calculated department populations.
    UPDATE Region r
    SET population = (
        SELECT SUM(d.population)
        FROM Departement d
        WHERE d.idRegion = r.idRegion
    );
END;
$$ LANGUAGE plpgsql;