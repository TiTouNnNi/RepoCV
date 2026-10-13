import random as r

CAPACITE_MAX = 15
POIDS   =       [2, 3, 4, 5,  9]
VALEURS =       [3, 4, 8, 8, 10]
N = len(POIDS)

def individu():
    return [r.randint(0,1) for _ in range(N)]

def fitness(individu):
    return sum(individu[i]* VALEURS[i] for i in range(N))

def penalty(individu, type_penalite="lineaire"):
    poids_total = sum(individu[i] * POIDS[i] for i in range(N))
    valeur_totale = sum(individu[i] * VALEURS[i] for i in range(N))
    
    if poids_total <= CAPACITE_MAX:
        print('Poids sans dépassement :' ,poids_total,'Valeur sans dépassement :' ,valeur_totale)
        return valeur_totale
        
    depassement = poids_total - CAPACITE_MAX
    
    if type_penalite == "death":
        print("Death penalty")
        return 0
    elif type_penalite == "lineaire":
        alpha = 5 
        return max(0, valeur_totale - (alpha * depassement))

indiv = individu()



print(penalty(indiv))
