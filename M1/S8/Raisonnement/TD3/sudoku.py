from ortools.sat.python import cp_model

clues = [
    [0, 2, 0, 5, 0, 1, 0, 9, 0],
    [8, 0, 0, 2, 0, 3, 0, 0, 6],
    [0, 3, 0, 0, 6, 0, 0, 7, 0],
    [0, 0, 1, 0, 0, 0, 6, 0, 0],
    [5, 4, 0, 0, 0, 0, 0, 1, 9],
    [0, 0, 2, 0, 0, 0, 7, 0, 0],
    [0, 9, 0, 0, 3, 0, 0, 8, 0],
    [2, 0, 0, 8, 0, 4, 0, 0, 7],
    [0, 1, 0, 9, 0, 7, 0, 6, 0]
]

model = cp_model.CpModel()

print(clues[0][1])

vars = [[model.NewIntVar(1,9,f'x_{i},{j}') for i in range(1,10)]for j in range(1,10)]

#print(vars)

#Contraintes
for i in range(9):
    model.AddAllDifferent(vars[i])
    #valeurs différentes colonne
    model.AddAllDifferent(vars[j][i] for j in range(9))

#valeurs différentes blocs
for bi in range(3):
    for bj in range(3):
        block = []
        for i in range(3):
            for j in range(3):
                # On récupère la variable aux coordonnées calculées
                block.append(vars[bi * 3 + i][bj * 3 + j])
        model.AddAllDifferent(block)

for i in range(9):
    for j in range(9):
        if clues[i][j] != 0:
            model.Add(vars[i][j] == clues[i][j])

#Solve
solver = cp_model.CpSolver()
status = solver.Solve(model)
if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
    print('Solution:')
    for i in range(9):
        row = []
        for j in range(9):
            row.append(solver.Value(vars[i][j]))
        print(row)
else:
    print('No solution found')
        

