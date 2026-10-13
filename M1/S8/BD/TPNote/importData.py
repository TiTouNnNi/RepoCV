import pandas as pd
import psycopg
import io

def show_rows(df, nrows=1000):
    with pd.option_context("display.max_rows", nrows): print(df)

commune = pd.read_csv("v_commune_2026.csv").drop(columns=["TYPECOM", "REG","CTCD","ARR","TNCC","NCC","NCCENR","CAN","COMPARENT"])

commune = commune.rename(columns={"DEP":"idd"})
commune = commune.rename(columns={"COM":"codegeo"})

show_rows(commune)

departement = pd.read_csv("v_departement_2026.csv").drop(columns=["CHEFLIEU","TNCC","NCC","NCCENR"])
"DEP","REG","CHEFLIEU","TNCC","NCC","NCCENR","LIBELLE"

departement = departement.rename(columns={"DEP": "idd"})
departement = departement.rename(columns={"REG": "idr"})


region = pd.read_csv("v_region_2026.csv").drop(columns=["CHEFLIEU","TNCC","NCC","NCCENR"])
region = region.rename(columns={"REG":"idr"})

print('Connexion à la base de données...')
USERNAME="aikahloul"
PASS="vamos"
HOST='pgsql'
with psycopg.connect("host="+HOST+" user="+USERNAME+" password="+PASS) as conn:
    print('Connecté à la base de données')
    with conn.cursor(row_factory=psycopg.rows.dict_row) as cur:
        print("Insertion données REGION")
        buffer_region = io.StringIO()
        region.to_csv(buffer_region, index=False, header=False, sep='\t')
        buffer_region.seek(0)
        with cur.copy("COPY Regions (idr,libelle) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_region.read())
        
        print('Insertion données DEPARTEMENT')
        buffer_dep = io.StringIO()
        departement.to_csv(buffer_dep, index=False, header=False, sep='\t')
        buffer_dep.seek(0)
        with cur.copy("COPY Departements (idd,idr,libelle) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_dep.read())

        print('Insertion données COMMUNE')
        buffer_commune = io.StringIO()
        commune.to_csv(buffer_commune, index=False, header=False, sep='\t')
        buffer_commune.seek(0)
        with cur.copy("COPY Communes (idc,idd,libelle,codgeo) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_commune.read())

