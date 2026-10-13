import random as r

def init_tau(g):
    return {node:{neighbor: 1.0 for neighbor in g[node]} for node in g}

def transition_probabilities(g,state, visited, tau, alpha, beta):
    tp = {}
    for neighbor in g[state]:
        if neighbor not in visited:
            tp[neighbor] = tau[state][neighbor]**alpha * (1.0/ g[state][neighbor]+1e-10)**beta
    total_tp = sum(tp.values())
    return {neighbor: tp[neighbor]/total_tp for neighbor, _ in tp.items()}



def find_solution(g,start, tau, alpha, beta):
    solution = [start]
    visited = set(solution)
    while len(visited) < len(g):
        current_state = solution[-1]
        probabilities = transition_probabilities(g, current_state, visited, tau, alpha, beta)
        if not probabilities:
            break
        next_node = r.choices(list(probabilities.keys()), weights=list(probabilities.values()), k=1)[0]
        solution.append(next_node)
        visited.add(next_node)
    if len(solution) < len(g):
        return None
    solution.append(start)
    return solution

def eval(g,s):
    if s is None:
        return float('inf')
    return sum([g[s[i]][s[i+1]] for i in range(len(s)-1)])

def evaporate(tau,rho):
    return {node:{neighbor: tau[node][neighbor]*(1-rho) for neighbor in tau[node]} for node in tau}

def reinforce(g, tau, s, Q):
    for i in range(len(s)-1):
        tau[s[i]][s[i+1]] += Q/eval(g, s)
    return tau

def tsp_aco(g, start, alpha=1.0, beta=1.0, Q=1.0, rho=0.1, nb_ants=10, max_iterations=100):
    tau = init_tau(g)
    for _ in range(max_iterations):
        solutions= [] # Solutions construites par les fourmis
        evals = [] # Evaluation des solutions
        for _ in range(nb_ants):
            solution = find_solution(g, start, tau, alpha, beta)
            solutions.append(solution)
            evals.append(eval(g, solution))
        tau = evaporate(tau, rho)
        solutions.sort(key=lambda s: eval(g,s))
        s_star = solutions[0]
        tau = reinforce(g, tau, s_star, Q)
    return s_star

if __main__ == "__main__":
    graph = {
        1:{2:1,4:3,6:7},
        2:{1:2,3:5,4:2},
        3:{2:5,4:1,5:5},
        4:{1:3,2:2,3:1},
        5:{3:5,6:6},
        6:{1:7,5:6}
    }
    best_solution = tsp_aco(graph,start=1, nb_ants=len(graph))