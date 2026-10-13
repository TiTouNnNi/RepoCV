flight(cdg, jfk, 6).
flight(cdg, vie, 3).
flight(cdg, icn, 11).
flight(icn, jfk, 14).
flight(icn, vie, 9).
flight(jfk, vie, 7).

flight(A2, A1, Duration) :- flight(A1,A2,Duration).

%On considère les noeuds 'villes'
city(City) :- flights(City, _, _).

%On ne peut passer que par une ville obligatoirement
{ plan(CurrentCity, NextCity, Duration) : flight(CurrentCity, NextCity, Duration) } 1 :- city(CurrentCity).

% Une ville ne peut pas être le point d'arrivée de plus d'un vol dans le plan
:- plan(Source1, City, _), plan(Source2, City, _), Source1 != Source2.

%CDG est le point de départ, on ne peut donc jamais y arriver
:- plan(_, cdg, _).

% Toutes les villes sauf CDG doivent être une destination
:- city(City), City != cdg, not plan(_, City, _).

%La ville suivant est visité
reached(NextCity) :- reached(CurrentCity), plan(CurrentCity, NextCity, _).

:- city(City), not reached(City).

%On veut le moins de temps possible
#minimize { Duration, CurrentCity, NextCity : plan(CurrentCity, NextCity, Duration) }.