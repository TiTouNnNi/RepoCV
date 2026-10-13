import pandas as pd
import psycopg
import io

data = pd.read_csv("base-cc-serie-historique-2020.csv",sep=";",dtype={"DEP": str, "REG": str, "CODGEO": str})


dep = data[["DEP","REG"]].drop_duplicates(subset=["DEP"])
dep.columns = ["codeDepartement", "codeRegion"]

def show_rows(df, nrows=1000):
    with pd.option_context("display.max_rows", nrows): print(df)

show_rows(dep)

region = data[["REG"]].drop_duplicates(subset=["REG"]).rename(columns={"REG":"codeRegion"})

commune = data[["CODGEO","SUPERF","LIBGEO","DEP"]].drop_duplicates(subset=["CODGEO"])
commune.columns = ["codeCommune","superficie","nomCommune","codeDepartement"]

pop_columns = ['P20_POP', 'P14_POP', 'P09_POP', 'D99_POP', 'D90_POP', 'D82_POP', 'D75_POP', 'D68_POP']
pop = data.melt(id_vars=['CODGEO'],value_vars=pop_columns,var_name='period_code',value_name='valeurPopulation')

year_mapping = {
        'P20_POP': '2020-01-01', 
        'P14_POP': '2014-01-01', 
        'P09_POP': '2009-01-01', 
        'D99_POP': '1999-01-01',
        'D90_POP': '1990-01-01', 
        'D82_POP': '1982-01-01', 
        'D75_POP': '1975-01-01', 
        'D68_POP': '1968-01-01'
    }


pop['annee'] = pop['period_code'].map(year_mapping)
pop.rename(columns={"CODGEO":"codeCommune"}, inplace=True)
pop_final = pop[['annee', 'valeurPopulation', 'codeCommune']]

nais_columns = ['NAIS1420', 'NAIS0914', 'NAIS9909', 'NAIS9099', 'NAIS8290', 'NAIS7582', 'NAIS6875']
nais = data.melt(
    id_vars=['CODGEO'], 
    value_vars=nais_columns, 
    var_name='period_code', 
    value_name='valeurNaissance'
)
nais_debut_map = {
    'NAIS1420': '2014', 'NAIS0914': '2009', 'NAIS9909': '1999', 
    'NAIS9099': '1990', 'NAIS8290': '1982', 'NAIS7582': '1975', 'NAIS6875': '1968'
}
nais_fin_map = {
    'NAIS1420': '2020', 'NAIS0914': '2014', 'NAIS9909': '2009', 
    'NAIS9099': '1999', 'NAIS8290': '1990', 'NAIS7582': '1982', 'NAIS6875': '1975'
}
nais['anneeDebutNaissance'] = nais['period_code'].map(nais_debut_map)
nais['anneeFinNaissance'] = nais['period_code'].map(nais_fin_map)
nais.rename(columns={"CODGEO": "codeCommune"}, inplace=True)
nais_final = nais[['anneeDebutNaissance', 'valeurNaissance', 'anneeFinNaissance', 'codeCommune']]

deces_columns = ['DECE1420', 'DECE0914', 'DECE9909', 'DECE9099', 'DECE8290', 'DECE7582', 'DECE6875']
deces = data.melt(
    id_vars=['CODGEO'], 
    value_vars=deces_columns, 
    var_name='period_code', 
    value_name='valeurDeces'
)
deces_debut_map = {
    'DECE1420': '2014-01-01', 'DECE0914': '2009-01-01', 'DECE9909': '1999-01-01', 
    'DECE9099': '1990-01-01', 'DECE8290': '1982-01-01', 'DECE7582': '1975-01-01', 'DECE6875': '1968-01-01'
}
deces_fin_map = {
    'DECE1420': '2020-01-01', 'DECE0914': '2014-01-01', 'DECE9909': '2009-01-01', 
    'DECE9099': '1999-01-01', 'DECE8290': '1990-01-01', 'DECE7582': '1982-01-01', 'DECE6875': '1975-01-01'
}
deces['anneeDebutDeces'] = deces['period_code'].map(deces_debut_map)
deces['anneeFinDeces'] = deces['period_code'].map(deces_fin_map)
deces.rename(columns={"CODGEO": "codeCommune"}, inplace=True)
deces_final = deces[['anneeDebutDeces', 'anneeFinDeces', 'valeurDeces', 'codeCommune']]

print(pop_final)

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
        with cur.copy("COPY Region (codeRegion) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_region.read())
        
        print('Insertion données DEPARTEMENT')
        buffer_dep = io.StringIO()
        dep.to_csv(buffer_dep, index=False, header=False, sep='\t')
        buffer_dep.seek(0)
        with cur.copy("COPY Departement (codeDepartement, codeRegion) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_dep.read())

        print('Insertion données COMMUNE')
        buffer_commune = io.StringIO()
        commune.to_csv(buffer_commune, index=False, header=False, sep='\t')
        buffer_commune.seek(0)
        with cur.copy("COPY Commune (codeCommune, superficie, nomCommune, codeDepartement) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_commune.read())

        print('Insertion données POPULATION')
        buffer_pop = io.StringIO()
        pop_final.to_csv(buffer_pop, index=False, header=False, sep='\t')
        buffer_pop.seek(0)
        with cur.copy("COPY Population (annee, valeurPopulation, codeCommune) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_pop.read())

        print('Insertion données NAISSANCE')
        buffer_nais = io.StringIO()
        nais_final.to_csv(buffer_nais, index=False, header=False, sep='\t')
        buffer_nais.seek(0)
        with cur.copy("COPY Naissance (anneeDebutNaissance, valeurNaissance, anneeFinNaissance, codeCommune) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_nais.read())

        print('Insertion données DECES')
        buffer_deces = io.StringIO()
        deces_final.to_csv(buffer_deces, index=False, header=False, sep='\t')
        buffer_deces.seek(0)
        with cur.copy("COPY Deces (anneeDebutDeces, anneeFinDeces, valeurDeces, codeCommune) FROM STDIN WITH (FORMAT CSV, DELIMITER '\t')") as copy:
            copy.write(buffer_deces.read())
        
    conn.commit()
    print('Import des données réussi')
