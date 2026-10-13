import random as r

def random_example(n):
    return [r.randint(0,1) for _ in range(n)]

def init_population(P,n):
    return[random_example(n) for _ in range(P)]

def mutation(individu, p=.1):
    return [x[i]^1 if r.random() < p else x[i] for i in range (len(x))]

fitness = lambda x : sum(x)

select = lambda pop : max(pop, key=fitness)

if __name__ == '__main__':
    n = 10
    P = 5
    #individu = random_example(n)
    #print("Un individu", individu)
    population = init_population(P,n)
    print("Population :", population)
    for x in population:
        print('Inv :' ,x, ' fitness : ', fitness(x))

    best = select(population)
    print("Le meilleur : ", best, ' fitness : ', fitness(best))
    mutant = mutation(best)
    print("Le mutant : ", mutant, ' fitness mutant: ', fitness(mutant))
