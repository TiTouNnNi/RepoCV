import pandas as pd
import psycopg
import io

# ==============================================================================
# 1. READ CSV FILES
# We read files as strings (dtype=str) to prevent pandas from deleting 
# leading zeros in INSEE codes (like '01' or '2A').
# ==============================================================================
df_region = pd.read_csv("cog_ensemble_2024_csv/v_region_2024.csv", dtype=str)
df_departement = pd.read_csv("cog_ensemble_2024_csv/v_departement_2024.csv", dtype=str)
df_commune = pd.read_csv("cog_ensemble_2024_csv/v_commune_2024.csv", dtype=str)

# Filter to keep only standard communes (COM)
df_commune = df_commune[df_commune["TYPECOM"] == "COM"]

# ==============================================================================
# 2. GENERATE OUR OWN NUMERIC IDs
# We create sequential numeric IDs (1, 2, 3...) to replace the string codes
# for our database, as requested in the project guidelines.
# ==============================================================================
df_region['idRegion'] = range(1, len(df_region) + 1)
df_departement['idDepartement'] = range(1, len(df_departement) + 1)
df_commune['idCommune'] = range(1, len(df_commune) + 1)

# ==============================================================================
# 3. LINK THE TABLES TOGETHER (FOREIGN KEYS)
# We need to tell each department which 'idRegion' it belongs to, 
# and each commune which 'idDepartement' it belongs to.
# ==============================================================================
# Map the string code 'REG' to our new 'idRegion'
mapping_region = df_region.set_index('REG')['idRegion'].to_dict()
df_departement['fk_idRegion'] = df_departement['REG'].map(mapping_region)

# Map the string code 'DEP' to our new 'idDepartement'
mapping_departement = df_departement.set_index('DEP')['idDepartement'].to_dict()
df_commune['fk_idDepartement'] = df_commune['DEP'].map(mapping_departement)

# ==============================================================================
# 4. FORMAT DATAFRAMES FOR THE DATABASE
# We rename columns to exactly match our SQL table definitions.
# ==============================================================================
reg_to_db = df_region[['idRegion', 'LIBELLE']].rename(
    columns={"LIBELLE": "nomRegion"}
)

dep_to_db = df_departement[['idDepartement', 'LIBELLE', 'fk_idRegion']].rename(
    columns={"LIBELLE": "nomDepartement", "fk_idRegion": "idRegion"}
)

com_to_db = df_commune[['idCommune', 'LIBELLE', 'fk_idDepartement']].rename(
    columns={"LIBELLE": "nomCommune", "fk_idDepartement": "idDepartement"}
)

# Clean up communes that might not have a department match (prevents SQL errors)
com_to_db = com_to_db.dropna(subset=['idDepartement'])
com_to_db['idDepartement'] = com_to_db['idDepartement'].astype(int)

# ==============================================================================
# 5. DATABASE INSERTION
# ==============================================================================
print('Connexion à la base de données...')
USERNAME = "aikahloul"
PASS = "vamos"
HOST = 'pgsql'

with psycopg.connect(f"host={HOST} user={USERNAME} password={PASS}") as conn:
    print('Connecté à la base de données')
    with conn.cursor() as cur:
        
        # --- INSERT REGIONS ---
        print("Insertion données REGION...")
        buffer_region = io.StringIO()
        reg_to_db.to_csv(buffer_region, index=False, header=False, sep='\t')
        buffer_region.seek(0)
        # Note: We now insert idRegion as well!
        with cur.copy("COPY Region (idRegion, nomRegion) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_region.read())
        
        # --- INSERT DEPARTEMENTS ---
        print('Insertion données DEPARTEMENT...')
        buffer_dep = io.StringIO()
        dep_to_db.to_csv(buffer_dep, index=False, header=False, sep='\t')
        buffer_dep.seek(0)
        # Note: We now insert idDepartement AND idRegion!
        with cur.copy("COPY Departement (idDepartement, nomDepartement, idRegion) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_dep.read())

        # --- INSERT COMMUNES ---
        print('Insertion données COMMUNE...')
        buffer_commune = io.StringIO()
        com_to_db.to_csv(buffer_commune, index=False, header=False, sep='\t')
        buffer_commune.seek(0)
        # Note: We insert idCommune AND idDepartement
        with cur.copy("COPY Commune (idCommune, nomCommune, idDepartement) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_commune.read())

        # --- UPDATE SERIAL SEQUENCES ---
        # Because we forced our own IDs into the SERIAL columns, we must tell 
        # PostgreSQL to update its internal counters so future manual inserts work.
        print('Mise à jour des séquences...')
        cur.execute("SELECT setval('region_idregion_seq', (SELECT MAX(idRegion) FROM Region));")
        cur.execute("SELECT setval('departement_iddepartement_seq', (SELECT MAX(idDepartement) FROM Departement));")
        cur.execute("SELECT setval('commune_idcommune_seq', (SELECT MAX(idCommune) FROM Commune));")

print("Importation terminée !")