from tulip import *
import numpy as np
import math

def Erdos_Renyi(N, p):
    """
    Generate a random graph with N vertices and probability p of having an edge between two vertices.
    """
    
    params = tlp.getDefaultPluginParameters("Erdős-Rényi Random Graph")
    params['nodes'] = N
    params['p'] = p

    G = tlp.importGraph("Erdős-Rényi Random Graph", params)
    return G
    """
    g = tlp.newGraph()
    vertices = [g.addNode() for _ in range(N)]
    for i in range(N):
        for j in range(i+1, N):
            if np.random.random() < p:
                g.addEdge(vertices[i], vertices[j])
    removed_edges = tlp.SimpleTest.makeSimple(g)
    return g
    """

def poisson(lamb, k):
    """
    Compute the Poisson probability of observing k events given a mean rate of lambda.
    """
    return (lamb ** k) * np.exp(-lamb) / math.factorial(k)

def distance_KS(dist1, dist2):
    """
    Compute the Kolmogorov-Smirnov distance between two distributions.
    """
    cdf1 = np.cumsum(dist1) / np.sum(dist1)
    cdf2 = np.cumsum(dist2) / np.sum(dist2)
    return np.max(np.abs(cdf1 - cdf2))

def dist_degrees(graph):
    """
    Compute the degree distribution of a graph.
    """
    degrees = [graph.deg(node) for node in graph.getNodes()]
    max_degree = max(degrees)
    dist = np.zeros(max_degree + 1)
    for degree in degrees:
        dist[degree] += 1
    return dist # / np.sum(dist)

def dist_KS_graphes(graph1, graph2):
    d1 = dist_degrees(graph1)
    d2 = dist_degrees(graph2)
    if len(d1) < len(d2):
        d1 = np.pad(d1, (0, len(d2) - len(d1)), 'constant')
    elif len(d2) < len(d1):
        d2 = np.pad(d2, (0, len(d1) - len(d2)), 'constant')
    return distance_KS(d1, d2)
