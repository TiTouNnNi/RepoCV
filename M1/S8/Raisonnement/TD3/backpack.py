# knapsack problem
from ortools.sat.python import cp_model

data = {
"capacity": 50,
    "items": [
        {"weight": 1, "value": 44},
        {"weight": 5, "value": 89},
        {"weight": 2, "value": 25},
        {"weight": 12, "value": 48},
        {"weight": 12, "value": 53},
        {"weight": 6, "value": 61},
        {"weight": 12, "value": 4},
        {"weight": 10, "value": 83},
        {"weight": 4, "value": 93},
        {"weight": 3, "value": 24},
        {"weight": 6, "value": 46},
        {"weight": 6, "value": 46},
        {"weight": 6, "value": 38},
        {"weight": 11, "value": 88},
        {"weight": 12, "value": 3},
        {"weight": 9, "value": 63},
        {"weight": 5, "value": 26},
        {"weight": 4, "value": 54},
        {"weight": 6, "value": 39},
        {"weight": 9, "value": 36}
    ]
}

capacity = data['capacity']
items = data['items']
weights = [item['weight'] for item in items]
values = [item['value'] for item in items]
num_items = len(items)

print(values)
model = cp_model.CpModel()
x = [model.NewBoolVar(f'x_{i}') for i in range(num_items)]

model.Add(sum([x[i]*weights[i] for i in range(num_items)]) <= capacity)

model.Maximize(sum([x[i]*values[i] for i in range(num_items)]))

solver = cp_model.CpSolver()
status = solver.Solve(model)

if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
    print('Solution :')
    print("Value:", solver.ObjectiveValue())
    print("Selected items")
    for i in range(num_items):
        if solver.Value(x[i]) ==1:
            print(f'Item {i} with weight {weights[i]} and value {values[i]}')
else:
    print('No solution found')