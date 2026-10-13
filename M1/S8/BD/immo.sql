DROP TABLE IF EXISTS Occupant;
DROP TABLE IF EXISTS Appart;
DROP TABLE IF EXISTS Immeuble;
DROP TABLE IF EXISTS Personne;

create table Personne(
Nom varchar CONSTRAINT PK_Nom PRIMARY KEY,
Age integer,
Profession varchar);

insert into Personne values
('Ross', 51, 'Informaticien'),
('Alice', 34, 'Cadre'),
('Rachel',23, 'Stagiaire'),
('William',52,'Acteur'),
('Doug',34,'Rentier')
;

create table Immeuble(
NomImmeuble varchar CONSTRAINT PK_NomImmeuble PRIMARY KEY,
Adresse varchar,
NbEtages integer,
AnneeConstruction integer,
NomGerant varchar, 
CONSTRAINT FK_NomGerant FOREIGN KEY (NomGerant) REFERENCES Personne(Nom)
);

insert into Immeuble(NomImmeuble,Adresse,NbEtages,AnneeConstruction,NomGerant) values
('Koudalou', '3 rue Blanche', 15, 1975, 'Doug'),
('Barabas', '2 Allee Nikos', 2, 1973, 'Ross')
;

Create table Appart(
NomImmeuble varchar,
NoAppart integer,
Superficie integer,
Etage integer,
CONSTRAINT PK_NoAppart_NomImmeuble PRIMARY KEY(NoAppart,NomImmeuble),
CONSTRAINT FK_NomImmeuble FOREIGN KEY (NomImmeuble) REFERENCES Immeuble(NomImmeuble)
);

insert into Appart values ('Koudalou', 1, 150, 14),
('Koudalou', 34, 50, 15),
('Koudalou', 51, 200, 2),
('Koudalou', 52, 50, 5),
('Barabas', 1, 250, 1),
('Barabas', 2, 250, 2);


create table Occupant(
NomImmeuble varchar,
NoAppart integer,
NomOccupant varchar PRIMARY KEY,
AnneeArrivee integer,
UNIQUE(NomImmeuble,NoAppart),
CONSTRAINT FK_NomOccupant FOREIGN KEY (NomOccupant) REFERENCES Personne(Nom),
FOREIGN KEY (NomImmeuble, NoAppart) REFERENCES Appart(NomImmeuble, NoAppart)
);

insert into Occupant values('Koudalou',1,'Rachel',1992),
('Barabas',1,'Doug',1994),
('Barabas',2,'Ross',1994),
('Koudalou',51,'William',1996),
('Koudalou',34,'Alice',1993);
