import pandas as pd
import psycopg
import io

commune = pd.read_csv("cog_ensemble_2024_csv/v_commune_2024.csv")
commune = commune[commune["TYPECOM"] == "COM"]

com = commune[['LIBELLE']].rename(columns={"LIBELLE":"nomCommune"})

departement = pd.read_csv("cog_ensemble_2024_csv/v_departement_2024.csv")
dep = departement[['LIBELLE']].rename(columns={"LIBELLE":"nomDepartement"})

region = pd.read_csv("cog_ensemble_2024_csv/v_region_2024.csv")
reg = region[['LIBELLE']].rename(columns={"LIBELLE":"nomRegion"})

def show_rows(df, nrows=1000):
    with pd.option_context("display.max_rows", nrows): print(df)

print('Connexion à la base de données...')
USERNAME="aikahloul"
PASS="vamos"
HOST='pgsql'
with psycopg.connect("host="+HOST+" user="+USERNAME+" password="+PASS) as conn:
    print('Connecté à la base de données')
    with conn.cursor(row_factory=psycopg.rows.dict_row) as cur:
        print("Insertion données REGION")
        buffer_region = io.StringIO()
        reg.to_csv(buffer_region, index=False, header=False, sep='\t')
        buffer_region.seek(0)
        with cur.copy("COPY Region (nomRegion) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_region.read())
        
        print('Insertion données DEPARTEMENT')
        buffer_dep = io.StringIO()
        dep.to_csv(buffer_dep, index=False, header=False, sep='\t')
        buffer_dep.seek(0)
        with cur.copy("COPY Departement (nomDepartement) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_dep.read())

        print('Insertion données COMMUNE')
        buffer_commune = io.StringIO()
        com.to_csv(buffer_commune, index=False, header=False, sep='\t')
        buffer_commune.seek(0)
        with cur.copy("COPY Commune (nomCommune) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_commune.read())

