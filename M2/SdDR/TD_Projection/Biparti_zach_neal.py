from tulip import *
import math

def p_value(common,total_V2,V2_neigbhors_u, V2_neighbors_v):
    p_value = 0.0
    var1 = total_V2 - common
    val1= math.comb(common,total_V2)
    val2=math.comb(var1,(V2_neigbhors_u-common))
    val3=math.comb((total_V2-V2_neigbhors_u),(V2_neighbors_v-common))

    val4=math.comb(total_V2,V2_neigbhors_u)
    val5 = math.comb(total_V2,V2_neighbors_v)

    p_value = (val1*val2*val3)/(val4*val5)
    print(p_value)
    return p_value

def zach_projection(graph: tlp.Graph):
    alpha = 0.05
    projection = graph.addSubGraph("V1_Zach")
    
    v1_nodes = []
    v2_nodes = []

    for node in graph.getNodes():
        if graph.getColorProperty("viewColor")[node] == tlp.Color.Raspberry:
            projection.addNode(node)
            v1_nodes.append(node)
        else:
            v2_nodes.append(node)        

    for i in range(len(v1_nodes)):
        for j in range(i+1,len(v1_nodes)):
            u = v1_nodes[i]
            v = v1_nodes[j]
            neighbors_u = set(graph.getInOutNodes(u))
            neighbors_v = set(graph.getInOutNodes(v))

            common_neighbors = neighbors_u.intersection(neighbors_v)
            hasNeighbors = len(common_neighbors)

            if hasNeighbors > 0:
                nbr_neighbors_u = len(neighbors_u)
                nbr_neighbors_v = len(neighbors_v)
                p_value = p_value(hasNeighbors,len(v2_nodes),nbr_neighbors_u,nbr_neighbors_v)
                new_edge = graph.addEdge(u, v)
                projection.addEdge(new_edge)

                if p_value < alpha:
                    new_edge = graph.addEdge(u, v)
                    projection.addEdge(new_edge)
            
    return projection