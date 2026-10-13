import psycopg

# Try to connect to an existing database
print('Connexion à la base de données...')
USERNAME="aikahloul"
PASS="vamos"
HOST='pgsql'
with psycopg.connect("host="+HOST+" user="+USERNAME+" password="+PASS) as conn:
    print('Connecté à la base de données')
    #O'; INSERT INTO DRAGONS(dragon,sexe,longueur,ecailles,crachefeu,enamour) values('HackingDeOuf2', 'M', 500, 4000, 'O', 'macho'); --
    #préparation de l'exécution des requêtes (à ne faire qu'une fois)
    with conn.cursor(row_factory=psycopg.rows.dict_row) as cur:
        command = "select * from dragons where dragons.crachefeu = %s;"
        print('On va exécuter sur la base de données la requête: ',command)
        ask_user = input("Dragon qui crache du feu ? O/N\n")
        try:
            # Lancement de la requête
            cur.execute(command,[ask_user])
        except Exception as e :
            #fermeture de la connexion
            exit("error when running: " + command + " : " + str(e))

        print("Récupération du résultat de la requête\n")
        print("Nombre de lignes dans le résultat: ", cur.rowcount)
        rows = cur.fetchall()
    #rows => liste de dictionnaires (chaque ligne du résultat de la requête est un dictionnaire dont la clé est le nom de l'attribut)

    #traitement des résultats
        page = ''
        for d in rows:
            page += d['dragon']+" a une longueur de "+str(d['longueur'])+" et "+str(d['ecailles']) + " écailles."
            if(d['sexe']=='M'):
                page +="C'est un mâle "
            else:
                page +="C'est une femelle "
                page += d['enamour']
                page += " "

            if(d['crachefeu']=='O'):
                page+="qui crache du feu.\n"
            else:
                page+="qui ne crache pas de feu.\n"
        print(page)