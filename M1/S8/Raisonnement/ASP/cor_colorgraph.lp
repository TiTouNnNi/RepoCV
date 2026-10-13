node(1..5).
edge(1,2). edge(2,3). edge(3,4). edge(2,4). edge(4,5).

colors(r;v;b).

{colorier(N,C) : node(N), colors(C)}.

:- colorier(A,C), colorier(A,D), C != D.
colored(A) :- node(A), colorier(A,C).
:- node(A), not colored(A).

:- edge(A,B), colorier(A,C), colorier(B,C).