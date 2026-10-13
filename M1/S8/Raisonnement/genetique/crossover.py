import random as r

def one_point_crossover(a,b):
    c = r.randint(1, len(a))
    child1, child2 = a[:c] + b[:c], b[:c] + a[:c]
    return c, child1, child2

A = [1,0,1,0,0,1,1,0]
B = [0,0,1,1,1,0,1,0]

print("Parent A: ", A)
print("Parent B :", B)

for _ in range(3):
    c, c1, c2 = one_point_crossover(A, B)
    print(f'Point de coupe = {c}')
    print(f'  Enfant 1 : {c1}')
    print(f'  Enfant 2 : {c2}')