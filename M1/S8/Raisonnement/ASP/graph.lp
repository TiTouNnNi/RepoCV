node(1..5).
edge(1,2). edge(2,3). edge(3,4). edge(2,4). edge(4,5).

color(1..3).

1{assign(N,C) : color(C)}1 :- node(N).

:- edge(Node1, Node2), assign(Node1, Color), assign(Node2, Color).