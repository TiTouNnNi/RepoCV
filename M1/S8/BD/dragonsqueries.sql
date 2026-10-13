ALTER TABLE Dragons
ADD Couleur VARCHAR(20),
ADD Etat_Dragon VARCHAR(20) CHECK (Etat_Dragon IN ('malade', 'disparu', 'mort', 'vivant')),
ADD Caractere VARCHAR(20) DEFAULT 'violent';
