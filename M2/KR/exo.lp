% règles d'inférence
grandparent(GP, PE) :- parent(GP,E), parent(E,PE).
fratrie(E,F) :- fratrie(F,E).
fratrie(E,F) :- fratrie(E,G), fratrie(G,F), E != F.
fratrie(E,F) :- parent(P,E), parent(P,F).
parent(P,F) :- parent(P,E), fratrie(E,F).

% contraintes d'intégrité
:- grandparent(A,A). % on ne peut pas être son propre grand-parent
:- parent(A,A). % on ne peut pas être son propre parent
:- parent(A,B), grandparent(A,B). % on ne peut pas être parent et grand-parent
                                  % d'une même personne

% données
{fact(parent(p,a))}.
{fact(fratrie(a,b))}.
{fact(parent(a,c))}.
{fact(parent(c,b))}.
{fact(parent(p,d))}.
{fact(fratrie(b,d))}.
%#maximize { 1,F: fact(F) }. %On compte le nombre de faits utilisés, le 1 c'est le poids qu'on donne au fait

