--La consigne indique de ne calculer que si toutes les communes du département ont été renseignées pour la nouvelle année.
-- Function triggered when a new statistic is inserted or updated.
CREATE OR REPLACE FUNCTION trg_calculate_population_if_complete()
RETURNS TRIGGER AS $$
DECLARE
    dept_id INT;
    stat_year INT;
    commune_count_in_dept INT;
    commune_count_with_stats INT;
BEGIN
    -- Only proceed if the statistic is related to population.
    IF (SELECT codeStat FROM StatType WHERE idStatType = NEW.idStatType) = 'POP' THEN
        
        -- Get the department ID for the modified commune.
        SELECT idDepartement INTO dept_id FROM Commune WHERE idCommune = NEW.idCommune;
        stat_year := EXTRACT(YEAR FROM NEW.dateFin);

        -- Count total communes in this department.
        SELECT COUNT(*) INTO commune_count_in_dept 
        FROM Commune 
        WHERE idDepartement = dept_id;

        -- Count how many communes in this department have stats for this specific year.
        SELECT COUNT(DISTINCT s.idCommune) INTO commune_count_with_stats
        FROM Statistique s
        JOIN Commune c ON s.idCommune = c.idCommune
        WHERE c.idDepartement = dept_id 
          AND s.idStatType = NEW.idStatType
          AND EXTRACT(YEAR FROM s.dateFin) = stat_year;

        -- If the data for the year is fully complete for the department, update caches.
        IF commune_count_in_dept = commune_count_with_stats THEN
            PERFORM update_cached_populations();
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the Statistique table.
CREATE TRIGGER trg_after_stat_change
AFTER INSERT OR UPDATE ON Statistique
FOR EACH ROW EXECUTE FUNCTION trg_calculate_population_if_complete();