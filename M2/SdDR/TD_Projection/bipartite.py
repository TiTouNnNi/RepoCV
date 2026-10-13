from tulip import *

def bipartite(graph):
    prop_viewColor = graph['viewColor']
    prop_viewColor.setAllNodeValue(tlp.Color.Aquamarine)
    import queue
    q = queue.Queue()
    n = graph.getOneNode()
    q.put(graph.getOneNode())
    graph['viewColor'][n] = tlp.Color.Raspberry
    while not q.empty():
        n = q.get()
        color_neighbors = tlp.Color.BlueGreen if graph['viewColor'][n] == tlp.Color.Raspberry else tlp.Color.Raspberry
        for nn in graph.getInOutNodes(n):
            if graph['viewColor'][nn] == tlp.Color.Aquamarine: # unmarked
                q.put(nn)
                graph['viewColor'][nn] = color_neighbors
            else:
                if graph['viewColor'][nn] == graph['viewColor'][n]:
                    return 'Not bipartite'
    return 'Bipartite'
