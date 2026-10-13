connected(A,B) :- edge(A,B).
connected(A,C) :- connected(A,B), edge(B,C).
:- node(A), node(B), not connected(A,B).