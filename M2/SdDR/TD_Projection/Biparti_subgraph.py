from tulip import *

def v1_projection(graph: tlp.Graph):

    projection = graph.addSubGraph("V1_Projection")
    view_metric = graph.getDoubleProperty("viewMetric")
    
    v1_nodes = []
    for node in graph.getNodes():
        if graph.getColorProperty("viewColor")[node] == tlp.Color.Raspberry:
            projection.addNode(node)
            v1_nodes.append(node)        

    for i in range(len(v1_nodes)):
        for j in range(i+1,len(v1_nodes)):
            u = v1_nodes[i]
            v = v1_nodes[j]
            neighbors_u = set(graph.getInOutNodes(u))
            neighbors_v = set(graph.getInOutNodes(v))

            common_neighbors = neighbors_u.intersection(neighbors_v)
            edge_weight = len(common_neighbors)

            if edge_weight > 0:
                new_edge = graph.addEdge(u, v)
                projection.addEdge(new_edge)
                view_metric[new_edge] = edge_weight
            
    return projection