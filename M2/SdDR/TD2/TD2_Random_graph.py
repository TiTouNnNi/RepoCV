import math
import numpy as np

from tulip import *

def Erdos_Renyi(N, p):
    g = tlp.newGraph()
    vertices = [g.addNode() for _ in range(N)]
    for i in range(N):
        for j in range(i+1, N):
            if np.random.random() < p:
                g.addEdge(vertices[i], vertices[j])
    removed_edges = tlp.SimpleTest.makeSimple(g)
    return g


def poisson(lam,k):
    sum = 0
    for i in range(k):
        sum += ((lam**i)*(math.exp(-lam)))/(math.factorial(i))
    return sum

def distance_KS(d1,d2):
    cumsum_d1 = np.cumsum(d1) / np.sum(d1)
    cumsum_d2 = np.cumsum(d2) / np/sum(d2)
    max = 0
    for i in cumsum_d1: #On part du principe que les deux distrubtions ont même taille
        if max < abs(cumsum_d1[i] - cumsum_d2[i]):
            max = abs(cumsum_d1[i] - cumsum_d2[i])
    return max # ou np.max(abs(cumsum_d1-cumsum_d2))

def dist_degree(graph):
    degree = graph.getIntegerProperty("degree")
    d_degree = []
    for n in graph.getNodes():
        degree.setNodeValue(n, graph.deg(n))

    for d in degree:
        d_degree[degree[d]] += 1

    return d_degree

def dist_KS_graphes(g1,g2):
    cg1 = dist_degree(g1)
    cg2 = dist_degree(g2)
    return distance_KS(cg1,cg2)

def dist_KS_theo(g):
    params = tlp.getDefaultPluginParameters('Erdős-Rényi Random Graph')
    n = params.get('nodes')
    p = params.get('p')
    l = (n-1)*p
    f = dist_degree(g)
    nbr = len(f)
    for i in nbr:
        max = poisson(l,nbr)

def p_estimator(graph):
    num_nodes = graph.numberOfNodes()
    num_edges = graph.numberOfEdges()

    if num_nodes <= 1:
        return 0.0

    return (2.0 * num_edges) / (num_nodes * (num_nodes - 1))

def p_value(nb_trials, graph):
    base_distance = dist_KS_theo(graph)
    num_nodes = graph.numberOfNodes()
    p = p_estimator(graph)

    count_greater = 0

    for _ in range(nb_trials):
        random_graph = tlp.newGraph()
        
        params = tlp.getDefaultPluginParameters('Erdős-Rényi Random Graph')
        params['nodes'] = num_nodes
        params['p'] = p
        random_graph.applyAlgorithm('Erdős-Rényi Random Graph', params)

        trial_distance = dist_KS_theo(random_graph)
        
        if trial_distance > base_distance:
            count_greater += 1
            
        del random_graph

    return count_greater / nb_trials


def diametre(graph):
    params = tlp.getDefaultPluginParameters('Eccentricity')
    params['norm'] = False
    eccentricity = graph.getDoubleProperty('Eccentricity')
    graph.applyDoubleAlgorithm('Eccentricity', eccentricity, params)
    
    return max([eccentricity[n] for n in graph.getNodes()])


def ave_stddev(nb_trials, N, p):
    diam = []
    for _ in range(nb_trials):
        G = Erdos_Renyi(N, p)
        diam.append(diametre(G))

    mean_diam = np.mean(diam)
    std_diam = np.std(diam)

    return mean_diam, std_diam

def z_score(graph, nb_trials=100):
    num_nodes = graph.numberOfNodes()
    p = p_estimator(graph)

    mu, sigma = ave_stddev(nb_trials, num_nodes, p)

    if sigma == 0:
        return 0.0

    graph_diam = diametre(graph)
    return (graph_diam - mu) / sigma


D = tlp.loadGraph('dolphin_network.tlp')
K = tlp.loadGraph('karate_club.tlp')

print(z_score(D,100))
        
