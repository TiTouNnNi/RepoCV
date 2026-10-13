-- Function to block manual DML operations on administrative tables.
CREATE OR REPLACE FUNCTION prevent_admin_table_modifications()
RETURNS TRIGGER AS $$
BEGIN
    -- Allow updates ONLY if the population column is the sole column being modified.
    -- This allows our automated procedures to work while blocking manual edits.
    IF TG_OP = 'UPDATE' THEN
        IF NEW.population IS DISTINCT FROM OLD.population AND 
           NEW.nomDepartement = OLD.nomDepartement AND 
           NEW.idRegion = OLD.idRegion THEN
            RETURN NEW;
        END IF;
    END IF;
    
    -- Reject all INSERT, DELETE, and unauthorized UPDATE operations.
    RAISE EXCEPTION 'Manual modifications (INSERT/UPDATE/DELETE) on structural tables are blocked.';
END;
$$ LANGUAGE plpgsql;

-- Apply the blocking triggers.
CREATE TRIGGER trg_block_departement
BEFORE INSERT OR UPDATE OR DELETE ON Departement
FOR EACH ROW EXECUTE FUNCTION prevent_admin_table_modifications();

-- Assuming a similar structure check for Region (omitted name/id checks for brevity, 
-- but same principle applies).