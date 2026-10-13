grandparent(GP, PE) :- parent(GP,E), parent(E,PE).
fratrie(E,F) :- fratrie(F,E).
parent(P,F) :- parent(P,E), fratrie(E,F).

parent(p,a).
fratrie(a,b).
parent(a,c).
parent(c,b).