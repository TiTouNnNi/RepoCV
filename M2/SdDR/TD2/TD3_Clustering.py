import math
import numpy as np

from pydash import drop
from tulip import *


def createGraphT_N_K(N, K):
    graph = tlp.newGraph()
    vertices = [graph.addNode() for _ in range(N)]
    
    for i in range(N):
        for j in range(1, (K // 2) + 1):
            graph.addEdge(vertices[i], vertices[(i + j) % N])
            
    tlp.SimpleTest.makeSimple(graph)
    return graph

def cluster_coeff(G, node):
    degree = G.deg(node)
    
    if degree <= 1:
        return 0.0
        
    neighbors = list(G.getInOutNodes(node))
    sum_valid = 0.0
    
    for n in neighbors:
        for nn in neighbors:
            if n == nn:
                continue
            if G.existEdge(n, nn).isValid():
                sum_valid += 1

    clust_coeff = sum_valid / (degree * (degree - 1))
    return clust_coeff

def graph_cluster_coef(G):
    sum = 0.0
    for n in G.getNodes():
        sum += cluster_coeff(G,n)

    return sum / G.numberOfNodes()

def reroute_one(G):
    prop = G.getStringProperty('type')
    edges = list(G.getEdges())
    choose_from = list(filter(lambda x: prop[x] != 'rerouted', edges))
    edge_to_reroute = np.random.choice(list(choose_from))
    return edge_to_reroute

def Watts_Strogatz(N, k, r):
    
    G = createGraphT_N_K(N,k)
    nodes = list(G.getNodes())
    prop = G.getStringProperty('type')
    prop.setAllEdgeValue('original')

    for _ in range(r):
        edge = reroute_one(G)
        source = G.source(edge)
        new_target = np.random.choice(nodes)

        while new_target == source or G.existEdge(source, new_target).isValid():
            new_target = np.random.choice(nodes)

        new_edge = G.addEdge(G.source(edge),new_target)
        prop[new_edge] = 'rerouted'
        G.delEdge(edge)

    return G

graph = createGraphT_N_K(200,4)
print(graph_cluster_coef(graph))
watt_graph = Watts_Strogatz(200,4,25)
print(graph_cluster_coef(watt_graph))


