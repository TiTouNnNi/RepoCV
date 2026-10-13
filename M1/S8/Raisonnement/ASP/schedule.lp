% 6 cours de 3h chacun
lecture((c1;c2;c3;c4;c5;c6),(h1;h2;h3)).    

% profs
teacher((t1;t2;t3;t4)).    
    
% profs possibles par cours
teach(t1,(c1;c2)).    
teach(t2,c3).    
teach(t3,(c2;c5;c6)).    
teach(t4,(c4;c6)).    
    
% disponibilté des profs
avail(t1,(mon;tue;wed),9..11).    
avail(t2,(tue;thu),14..16).    
avail(t3,(tue;wed;thu;fri),10..14).    
avail(t4,(mon;tue;wed;thu;fri),9..11).    
    
% heures possibles pour les cours
slot((mon;tue;wed;thu;fri),9..11).    
slot((mon;tue;wed;thu;fri),14..16).

%Un prof par cours
1{assign(Course,Teacher) : teacher(Teacher)}1 :- course(Course).

%Un créneau jour/heure par cours
1{schedule(Course,Day,Hour) : day(Day), hour(Hour)}1 :- course(Course).

%On ne peut pas avoir un cours avec un prof pas disponible 
:- schedule(Course,Day,Hour), assign(Course,Teacher), not avail(Teacher, Day, Hour).

:- schedule(Course1, Day, Hour), schedule(Course2, Day, Hour), Course1 != Course2.

