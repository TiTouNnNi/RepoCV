-- Creates a B-Tree index on the 'valeur' column to speed up range queries.
CREATE INDEX idx_stat_valeur ON Statistique(valeur);

-- Re-run the analysis to observe the performance improvement.
EXPLAIN ANALYZE 
SELECT * FROM Statistique s
JOIN StatType st ON s.idStatType = st.idStatType
WHERE st.codeStat = 'POP' AND s.valeur < 5000;