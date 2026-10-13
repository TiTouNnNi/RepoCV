flight(cdg, jfk, 6).
flight(cdg, vie, 3).
flight(cdg, icn, 11).
flight(icn, jfk, 14).
flight(icn, vie, 9).
flight(jfk, vie, 7).

flight(A2, A1, Duration) :- flight(A1,A2,Duration).

{ plan(CurrentCity, NextCity, Duration) } :- flight(CurrentCity, NextCity, Duration).

%Une ville ne peut pas être le point de départ de plus d'un vol dans le plan
:- plan(City, Dest1, _), plan(City, Dest2, _), Dest1 != Dest2.

%Une ville ne peut pas être le point d'arrivée de plus d'un vol dans le plan
:- plan(Source1, City, _), plan(Source2, City, _), Source1 != Source2.

%Inutile
% can_fly(City1, City2) :- flight(City1, City2, Duration), City1 != City2.

%:- #sum {Duration : plan(CurrentCity, NextCity, Duration) } > 24.

visited(City) :- plan(City, _, _).
visited(City) :- plan(_, City, _).

%La ville de départ n'est jamais une destination dans le plan
start_city(City) :- visited(City), not plan(_, City, _).

reached(City) :- start_city(City).

%On atteint la ville suivante dans le plan
reached(NextCity) :- reached(CurrentCity), plan(CurrentCity, NextCity, _).

:- visited(City), not reached(City).

%On veut visiter le plus de ville possible
#maximize { 1, City : visited(City) }.