#const n=3
node(1..n).
{ edge(A,B) : node(A), node(B), A != B }.


edge(I,J,S).
S = (1; -1).

{edge(A,B(1;-1)) : node (A), node(B), A != B}.
:- edge(A,B,1), edge(A,B,-1). %Contrainte d'intégrité, soit arête positif, soit arête négative, pas les deux

%acyclic

dpath(X,Y) :- edge(X,Y,_).
dpath(X,Y) :- dpath(X,Z), edge(Z,Y,_).
:- dpath(X,X).

%connected
cpath(I,J) :- edge(J,I,_).
cpath(I,J) :- edge(I,J,_).


possible(O,A,(1;-1)) :- obs(O,_,_), node(A), not edge(_,A,_).
possible(O,A,S1*S2) :- node(A), edge(B,A,S1), obs(O,B,S2).
:- obs(O,A,S), not possible(O,A,S).

obs(obs1,1,1). obs(obs1,2,1). obs(obs1,3,-1). obs(obs1,4,-1). obs(obs1,5,-1).
obs(obs2,1,1). obs(obs2,2,1). obs(obs2,3,1). obs(obs2,4,1). obs(obs2,5,-1).
obs(obs3,1,1). obs(obs3,2,1). obs(obs3,3,1). obs(obs3,4,-1). obs(obs3,5,-1).
obs(obs4,1,-1). obs(obs4,2,1). obs(obs4,3,-1). obs(obs4,4,1). obs(obs4,5,-1).
obs(obs5,1,-1). obs(obs5,2,1). obs(obs5,3,-1). obs(obs5,4,-1). obs(obs5,5,-1).
obs(obs6,1,-1). obs(obs6,2,1). obs(obs6,3,-1). obs(obs6,4,1). obs(obs6,5,1).
obs(obs7,1,1). obs(obs7,2,-1). obs(obs7,3,-1). obs(obs7,4,1). obs(obs7,5,-1).
obs(obs8,1,1). obs(obs8,2,-1). obs(obs8,3,-1). obs(obs8,4,-1). obs(obs8,5,-1).
obs(obs9,1,1). obs(obs9,2,-1). obs(obs9,3,1). obs(obs9,4,1). obs(obs9,5,-1).
obs(obs10,1,1). obs(obs10,2,-1). obs(obs10,3,1). obs(obs10,4,-1). obs(obs10,5,-1).
obs(obs11,1,-1). obs(obs11,2,-1). obs(obs11,3,-1). obs(obs11,4,1). obs(obs11,5,-1).
obs(obs12,1,-1). obs(obs12,2,-1). obs(obs12,3,-1). obs(obs12,4,-1). obs(obs12,5,-1).
obs(obs13,1,1). obs(obs13,2,1). obs(obs13,3,-1). obs(obs13,4,1). obs(obs13,5,-1).
