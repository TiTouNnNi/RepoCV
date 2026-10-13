#Une même séquence graphique peut conduire à plusieurs graphes différents
#il faut bouger des paires d'arêtes pour ne pas modifier le degré

#Pour lancer le code il faut juste taper python Havel-Hakimi.py, le drawGraph ne fonctionne pas sauf que la suite n'est pas graphique
# La fonction recursive est censé fonctionner avec mon jeu de données

d_valid = [6,5,5,3,3,3,1]
d_notValid = [6,5,5,3,3,3]
d_notValid2 = [6,5,5,3,2,2,1]
d_rigolo = [6,5,5,4,2,2,1,1]

graph = {}

def isGraphic(d):
    print(d)

    if len(d) == 0:
        return True

    if len(d) > 0:
        for e in range(len(d) - 1):
            if e + 1 <= len(d) and d[e] == 0 and d[e+1] > 0:
                return False  
            if d[e] < 0:
                return False  
                   
    first = d.pop(0)

    if first > len(d):
        return False
    
    for i in range(first):
        d[i] = d[i] -1

    return isGraphic(d)

def ajouter_sommet(g,n):
    if n not in g:
        g[n] = []

def ajouter_arete(g,v,u):  
    if v not in g[u]:
        g[u].append(v)
    if u not in g[v]:
        g[v].append(u)

def drawGraph(d,g):
    if isGraphic(d):
        for n in range(len(d) - 1):
            ajouter_sommet(n)
            for m in range(d[n]):
                ajouter_arete(g,n,m)
        return g
    else: 
        return "Suite non graphique"

print(isGraphic(d_valid))
print(isGraphic(d_notValid))
print(isGraphic(d_notValid2))  
print(isGraphic(d_rigolo))

print(drawGraph(d_valid,graph))
print(drawGraph(d_notValid,graph))