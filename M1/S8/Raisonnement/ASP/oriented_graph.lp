node(1..5).
edge(1,2). edge(2,3). edge(3,4). edge(4,5).
edge(3,1). edge(2,4). edge(4,3). edge(5,1).


% choisir un ensemble d'arêtes
% (utiliser un prédicat de la forme "take(X,Y)")
{take(X, Y) : edge(X,Y)}.

% déduire les sommets qui sont la source des arêtes sélectionnées 
% (prédicat de la forme "source(X)")
source(X) :- take(X, _).

% déduire les sommets qui sont la cible des arêtes sélectionnées
% (prédicat de la forme "target(X)")
target(X) :- take(_,X).

% contrainte d'intégrité: le sommet 1 est bien à la source d'une arête
:- not source(1).

% contrainte d'intégrité: le sommet 5 est bien à la cible d'une arête
:- not target(5).

% contrainte d'intégrité: pour toute arête sélectionnée qui n'arrive 
% pas sur le sommet 5, une arête consécutive a bien été choisie
%:- not target(5), not source(5).
:- take(_,Y), Y!=5, not source(Y). 

% minimiser le nombre d'arêtes sélectionnées
#minimize { 1,X,Y: take(X,Y) }. % minimise le nombre de faits
