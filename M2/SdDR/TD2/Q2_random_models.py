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
