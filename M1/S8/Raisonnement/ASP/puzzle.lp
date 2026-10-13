1{murderer(adam); murderer(brown); murderer(clark)}1.
2{innocent(adam); innocent(brown); innocent(clark)}2.

:- murderer(X), innocent(X).

%Clark témoignage
ville(brown) :- innocent(clark).
ville(adam) :- innocent(clark).

%Adam témoignage
connaitre(brown) :- innocent(adam).

%Brown témoignage
not ville(brown) :- innocent(brown).
not connaitre(brown) :- innocent(brown).