-- Request an execution plan with timing and actual row counts.
EXPLAIN ANALYZE 
SELECT * FROM Statistique s
JOIN StatType st ON s.idStatType = st.idStatType
WHERE st.codeStat = 'POP' AND s.valeur < 5000;