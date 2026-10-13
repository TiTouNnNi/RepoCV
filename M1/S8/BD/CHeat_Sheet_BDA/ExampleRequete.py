import psycopg

# ==============================================================================
# DATABASE CONNECTION PARAMETERS
# ==============================================================================
USERNAME = "aikahloul"
PASS = "vamos"
HOST = 'pgsql'

def display_departments_in_region(cursor, region_name):
    """Fetches and displays the list of departments for a specific region.

    Args:
        cursor: The active psycopg database cursor object.
        region_name: A string representing the name of the region.
    """
    # Execute a simple join to find departments linked to the given region name.
    query = """
        SELECT d.nomDepartement
        FROM Departement d
        JOIN Region r ON d.idRegion = r.idRegion
        WHERE r.nomRegion = %s
        ORDER BY d.nomDepartement;
    """
    cursor.execute(query, (region_name,))
    results = cursor.fetchall()

    print(f"\n--- Départements de la région {region_name} ---")
    if results:
        for row in results:
            print(f"- {row[0]}")
    else:
        print("Aucun département trouvé pour cette région.")


def display_population_extremes_in_department(cursor, dept_name):
    """Finds the most and least populated communes in a given department.

    Assumes the statistic code for population is 'POP'. Uses the most recent
    statistic available for each commune.

    Args:
        cursor: The active psycopg database cursor object.
        dept_name: A string representing the department name.
    """
    # Uses window functions to rank communes by their most recent population data.
    query = """
        WITH RankedStats AS (
            SELECT 
                c.nomCommune, 
                s.valeur,
                ROW_NUMBER() OVER(PARTITION BY c.idCommune ORDER BY s.dateFin DESC) as rn
            FROM Commune c
            JOIN Departement d ON c.idDepartement = d.idDepartement
            JOIN Statistique s ON c.idCommune = s.idCommune
            JOIN StatType st ON s.idStatType = st.idStatType
            WHERE d.nomDepartement = %s AND st.codeStat = 'POP'
        )
        SELECT nomCommune, valeur 
        FROM RankedStats 
        WHERE rn = 1
        ORDER BY valeur DESC;
    """
    cursor.execute(query, (dept_name,))
    results = cursor.fetchall()

    print(f"\n--- Extrêmes de population dans le département : {dept_name} ---")
    if results:
        print(f"La commune la plus peuplée : {results[0][0]} avec {results[0][1]} habitants.")
        print(f"La commune la moins peuplée : {results[-1][0]} avec {results[-1][1]} habitants.")
    else:
        print("Données insuffisantes.")


def display_population_growth_rate(cursor, commune_name, start_year, end_year):
    """Calculates the population growth rate for a commune between two years.

    Args:
        cursor: The active psycopg database cursor object.
        commune_name: A string representing the name of the commune.
        start_year: An integer representing the starting year.
        end_year: An integer representing the ending year.
    """
    # Retrieves population values for the two specific years to calculate growth.
    query = """
        SELECT EXTRACT(YEAR FROM s.dateFin) AS annee, s.valeur
        FROM Statistique s
        JOIN Commune c ON s.idCommune = c.idCommune
        JOIN StatType st ON s.idStatType = st.idStatType
        WHERE c.nomCommune = %s 
          AND st.codeStat = 'POP' 
          AND EXTRACT(YEAR FROM s.dateFin) IN (%s, %s)
        ORDER BY annee;
    """
    cursor.execute(query, (commune_name, start_year, end_year))
    results = {int(row[0]): row[1] for row in cursor.fetchall()}

    print(f"\n--- Évolution de la population pour {commune_name} ({start_year} - {end_year}) ---")
    if start_year in results and end_year in results:
        pop_start = results[start_year]
        pop_end = results[end_year]
        growth = ((pop_end - pop_start) / pop_start) * 100
        
        print(f"Population en {start_year} : {pop_start} habitants.")
        print(f"Population en {end_year} : {pop_end} habitants.")
        
        # Display growth with a positive/negative indicator.
        trend = "Hausse" if growth > 0 else "Baisse"
        print(f"Taux d'évolution : {growth:.2f}% ({trend})")
    else:
        print("Données manquantes pour l'une ou les deux années demandées.")


# ==============================================================================
# EXECUTION BLOCK
# ==============================================================================
if __name__ == "__main__":
    print('Connexion à la base de données...')
    
    try:
        # Utilizing the context managers from your example for safe connection handling
        with psycopg.connect(f"host={HOST} user={USERNAME} password={PASS}") as conn:
            print('Connecté à la base de données.')
            
            with conn.cursor() as cur:
                # 1. Test query for a region
                display_departments_in_region(cur, 'Nouvelle-Aquitaine')
                
                # 2. Test query for a department
                display_population_extremes_in_department(cur, 'Gironde')
                
                # 3. Test query for a commune
                display_population_growth_rate(cur, 'Cadaujac', 2015, 2024)
                
    except psycopg.Error as e:
        print(f"Erreur lors de la connexion ou de l'exécution : {e}")