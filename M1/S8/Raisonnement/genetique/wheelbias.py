import random as r
from collections import Counter

def wheel_select(pop, fit):
    total = sum(fit)
    a = r.random()*total
    s = 0
    for x,f in zip(pop, fit):
        s += f
        if s >= a:
            return x
    return pop[-1]

def rank_select(pop, fits):
    order = sorted(range(len(pop)), key=lambda i : fits[i])
    ranked_pop = (pop[i] for i in order)
    weight = list(range(1, len(pop)+1))
    return wheel_select(ranked_pop, weight)

def tournament_select(pop, fits, k=2):
    i_best = None
    for _ in range(k):
        i = r.randint(0, len(pop)-1)
        if i_best is None or fits[i > fits[i_best]]:
            i_best = i
    return pop[i_best]

population = ['A', 'B', 'C', 'D']
fits = [1,2,3,4]

print("Probas théoriques ", {population[i]: fits[i]/sum(fits) for i in range(len(population))})

counts = Counter(wheel_select(population, fits) for _ in range(2000))
print("Fréquences observés ", {k : v/2000 for k,v in counts.items()})

counts_rank = Counter(rank_select(population, fits) for _ in range(2000))
print("Fréquences observés rank ", {k : v/2000 for k,v in counts_rank.items()})

counts_tournament = Counter(tournament_select(population, fits, k=2) for _ in range(2000))
print("Fréquences observés tournament ", {k : v/2000 for k,v in counts_tournament.items()})
