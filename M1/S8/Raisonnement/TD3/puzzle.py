from ortools.sat.python import cp_model

model = cp_model.CpModel()

def get_category(names, prefix):
    return [model.NewIntVar(0,len(names)-1, f'{prefix}_{name}') for name in names]

def invert(vars, names, solver):
    # On crée une liste vide de taille 5
    res = [None] * len(names)
    for i in range(len(vars)):
        # La valeur de la variable nous donne l'indice de la maison (0-4)
        house_index = solver.Value(vars[i])
        # On place le nom correspondant à cette variable dans la bonne maison
        res[house_index] = names[i]
    return res

# colors are yellow, green, red, white, and blue
colors = yellow, green, red, white, blue = get_category(['yellow','green','red','white','blue'],'color')
model.AddAllDifferent(colors)

#• nations of inhabitants are italy, spain, japan, england, and norway
nations = italy, spain, japan, england, norway = get_category(['japan','spain','norway','england','italy'],'nations')
model.AddAllDifferent(nations)

#• pets are cat, zebra, bear, snails, and horse
pets = cat, zebra, bear, snails, horse = get_category(['cat','zebra','bear','snails','horse'],'pet')
model.AddAllDifferent(pets)

#• drinks are milk, water, tea, coffee, and juice
drinks = milk, water, tea, coffee, juice = get_category(['milk','water','tea','coffee','juice'],'drinks')
model.AddAllDifferent(drinks)

#• jobs are painter, sculptor, diplomat, pianist, and doctor
jobs = painter, sculptor, diplomat, pianist, doctor = get_category(['painter','sculptor','diplomat','pianist','doctor'],'jobs')
model.AddAllDifferent(jobs)

print(jobs)

#• the painter owns the horse
model.Add(painter == horse)
#• the diplomat drinks coffee
model.Add(diplomat == coffee)
#• the one who drinks milk lives in the white house
model.Add(milk == white)
#• the Spaniard is a painter
model.Add(spain == painter)
#• the Englishman lives in the red house
model.Add(england == red)
#• the snails are owned by the sculptor
model.Add(sculptor == snails)
#• the green house is on the left of the red one
model.Add(green < red)
#• the Norwegian lives on the right of the blue house
model.Add(norway > blue)
#• the doctor drinks milk
model.Add(doctor == milk)
#• the diplomat is Japanese
model.Add(diplomat == japan)
#• the Norwegian owns the zebra
model.Add(norway == zebra)
#• the green house is next to the white one
gw = model.NewIntVar(-1,1,'gw')
model.AddAbsEquality(gw, green - white)
model.Add(gw == 1)
#• the horse is owned by the neighbor of the diplomat
hd = model.NewIntVar(-1,1,'hd')
model.AddAbsEquality(hd, horse - diplomat)
model.Add(hd == 1)
#• the Italian either lives in the red, white or green house
italy_selector = model.NewIntVar(0,2, 'italy_selector')
model.AddElement(italy_selector, [red,white,green], italy)

solver = cp_model.CpSolver()
status = solver.Solve(model)

if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
    print('Solution :')
    color_at = invert(colors, ['yellow','green','red','white','blue'], solver)
    nations_at = invert(nations, ['japan','spain','norway','england','italy'], solver)
    pets_at = invert(pets, ['cat','zebra','bear','snails','horse'], solver)
    jobs_at = invert(jobs, ['painter','sculptor','diplomat','pianist','doctor'], solver)
    drinks_at = invert(drinks, ['milk','water','tea','coffee','juice'], solver)
    for h in range(5):
        print(f'house {h}: color ={color_at[h]}, nation ={nations_at[h]}, job={jobs_at[h]}, drink={drinks_at[h]}, pets={pets_at[h]}')
else:
    print('No solution found') 