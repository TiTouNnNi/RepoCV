import numpy as np
import random as rd
from grid_world import GridWorldMDP
#Policy Evaluation Algorithm
GAMMA = .9
def policy_evaluation(grid,policy, num_iterations = 100):
    S = grid.states
    A = grid.actions
    P = grid.transition_probabilities
    R = grid.rewards

    V = {s:0 for s in S}

    for _ in range(num_iterations):
        V = {s: sum(P[s, policy[s], sp]*(R[s,policy[s],sp]+GAMMA*V[sp]) 
                    for sp in S)
             for s in S}
        
    #Version pour les bébés (moi)
    #for s in grid.states:
    #    for sp in grid.states:
    #        somme += P[s, policy[s],sp]*(R[s,policy(s),sp]+GAMMA*V[sp])
    return V

def value_iteration(grid, num_iterations = 100):
    S = grid.states
    A = grid.actions
    P = grid.transition_probabilities
    R = grid.rewards

    V = {s:0 for s in S}

    for _ in range(num_iterations):
        V = {s:max(sum(P[s, a, sp]*(R[s,a,sp]+GAMMA*V[sp])for sp in S) for a in A) for s in S}

    #for s in S:
    #    for a in A:
    #        somme = 0
    #        for sp in S:
    #            somme = P[s,a,sp]*(R[s,a,sp]+GAMMA*V[sp]) # pas logique
    return V


def get_policy_from_value(grid,V):
    S = grid.states
    A = grid.actions
    P = grid.transition_probabilities
    R = grid.rewards

    policy = {s: max(A, key=lambda a:sum(P[s, a, sp]*(R[s,a,sp]+GAMMA*V[sp])for sp in S)) for s in S}
    return policy

def policy_iteration(grid):
    S = grid.states
    A = grid.actions
    P = grid.transition_probabilities
    R = grid.rewards
    random_policy = {s: rd.choice(A) for s in S}
    while True:
        V = policy_evaluation(grid,random_policy)
        policy = get_policy_from_value(grid,V)
        if policy == random_policy:
            return policy
        random_policy = policy
    return policy


if __name__ == '__main__':
    grid = GridWorldMDP(5,5,5)
    grid.print_board()
    V = value_iteration(grid)
    grid.print_value_function(V)
    policy = get_policy_from_value(grid,V)
    print('Using value iteration')
    grid.print_policy(policy)
    policy = policy_iteration(grid)
    print('Using policy iteration: ')
    grid.print_policy(policy)

