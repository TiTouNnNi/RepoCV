node(1..5).
edge(1,2). edge(2,3). edge(3,4). edge(2,4). edge(4,5).
{c(N) : node(N)}.
:- c(A), c(B), A != B, not edge(A,B), not edge(B, A).