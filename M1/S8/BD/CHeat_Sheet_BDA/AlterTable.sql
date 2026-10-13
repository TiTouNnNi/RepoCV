-- Ajout des colonnes pour stocker le chiffre de population le plus récent sans détruire les tables existantes.
-- Add population columns to store the most recent cached values.
ALTER TABLE Departement ADD COLUMN population INT;
ALTER TABLE Region ADD COLUMN population INT;