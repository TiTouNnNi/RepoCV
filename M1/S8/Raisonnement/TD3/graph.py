from ortools.sat.python import cp_model
import json

# helper : une fonction pour afficher le graphe avec ses couleurs :
def dessiner_carte(dep_colors, data):

    import matplotlib.pyplot as plt
    import networkx as nx
    G = nx.Graph()
    for dep, voisins in data.items():
        for voisin in voisins:
            G.add_edge(dep, voisin)

    palette = ['red', 'blue', 'green', 'yellow']
    nodelist = sorted(G.nodes()) # ordre fixé
    node_colors = [palette[dep_colors[n]] for n in nodelist]
    pos = nx.spring_layout(G, seed=0)
    nx.draw(G, pos,
    nodelist=nodelist,
    with_labels=True,
    node_color=node_colors,
    font_weight='bold')
    plt.show()

data = json.load(open('departements_connexions.json'))
#print(data)

dToi = {d:i for i,d in enumerate(data.keys())}
iTod = {i:d for i,d in enumerate(data.keys())}

model = cp_model.CpModel()

num_colors = 4

vars = [model.NewIntVar(0, num_colors-1, f'color{d}') for d in data.keys()]

#Contraintes
for d,neigh in data.items():
    for n in neigh:
        model.Add(vars[dToi[d]] != vars[dToi[n]])

solver = cp_model.CpSolver()
status = solver.Solve(model)

print(status)
if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
    print('SOlution:')
    for i,v in enumerate(vars):
        print(f'Departement{iTod[i]} --> color{solver.Value(v)}')
else:
    print('Solution not found')

#dessiner_carte(, data)