1{murderer(ms_Scarlet); murderer(colonel_Mustard)}1.
1{weapon(revolver); weapon(candlestick)}1.
1{place(kitchen); place(hall) ;place(dining_room)}1.
% indice 1
:- place(kitchen).
% indice 2
place(hall) :- murderer(colonel_Mustard), not weapon(revolver).
% indice 3
weapon(candlestick).