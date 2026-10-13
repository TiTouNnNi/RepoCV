DROP TABLE Combats;
DROP TABLE Chevalier;
DROP TABLE Amours;
DROP TABLE Repas;
DROP TABLE Nourritures;
DROP TABLE Dragons;

CREATE TABLE Dragons(
Dragon varchar(50),
Sexe char(1),
Longueur integer,
Ecailles integer,
CracheFeu char(1),
EnAmour varchar(10),
CONSTRAINT PK_Dragon PRIMARY KEY(Dragon),
CONSTRAINT LongueurPositif CHECK (Longueur > 0),
CONSTRAINT EcaillesPositif CHECK (Ecailles >= 0),
CONSTRAINT SexeMorF CHECK (Sexe in ('M', 'F')),
CONSTRAINT CracheFeuOorN CHECK (CracheFeu in ('O', 'N')),
CONSTRAINT EnAmourValid CHECK (EnAmour in ('macho','timide','sincère','volage'))
);

CREATE TABLE Nourritures (
    Produit VARCHAR(50),
    Calories INT,
    CONSTRAINT PK_Produit PRIMARY KEY(Produit),
    CONSTRAINT CaloriesPositive CHECK (Calories >=0)
);

CREATE TABLE Repas (
    Dragon VARCHAR(50),
    Produit VARCHAR(50),
    Quantite INT,
    CONSTRAINT QuantitePositif CHECK (Quantite > 0),
    CONSTRAINT PK_Dragon_Produit PRIMARY KEY(Dragon, Produit),
    CONSTRAINT FK_Dragon FOREIGN KEY(Dragon) REFERENCES Dragons(Dragon),
    CONSTRAINT FK_Produit FOREIGN KEY(Produit) REFERENCES Nourritures(Produit)
);

CREATE TABLE Amours (
    DragonAimant VARCHAR(50),
    DragonAime VARCHAR(50),
    Force VARCHAR(20),
    CONSTRAINT PK_DragonAimant PRIMARY KEY(DragonAimant),
    CONSTRAINT FK_DragonAimant FOREIGN KEY(DragonAimant) REFERENCES Dragons(Dragon),
    CONSTRAINT FK_DragonAime FOREIGN KEY(DragonAime) REFERENCES Dragons(Dragon),
    CONSTRAINT ForceValid CHECK (Force IN ('un peu', 'beaucoup', 'passionnement', 'a la folie'))
);

CREATE TABLE Chevalier (
    Matricule SERIAL,
    Nom VARCHAR(50),
    Parent INT,
    Rang VARCHAR(50),
    Solde INT,
    Etat VARCHAR(25),
    CONSTRAINT PK_Matricule PRIMARY KEY(Matricule),
    CONSTRAINT FK_Parent FOREIGN KEY(Parent) REFERENCES Chevalier(Matricule),
    CONSTRAINT EtatValid CHECK (Etat IN ('mort', 'retraité', 'malade', 'vacances')),
    CONSTRAINT SoldePositif CHECK (Solde >= 0)
);

CREATE TABLE Combats (
    Chevalier INT,
    Dragon VARCHAR(50),
    Date_Combat DATE,
    CONSTRAINT PK_Combats PRIMARY KEY (Chevalier, Dragon),
    CONSTRAINT FK_Chevalier FOREIGN KEY (Chevalier) REFERENCES Chevalier(Matricule),
    CONSTRAINT FK_Dragon FOREIGN KEY (Dragon) REFERENCES Dragons(Dragon)
);


INSERT INTO Dragons (Dragon, Sexe, Longueur, Ecailles, CracheFeu, EnAmour) VALUES
('Smeagol', 'M', 152, 1857, 'O', 'macho'),
('Birdurh', 'M', 258, 4787, 'N', 'timide'),
('Negueth', 'F', 128, 1582, 'O', 'sincère'), 
('MissToc', 'F', 183, 2781, 'N', 'volage'),
('Bolong', 'M', 213, 2754, 'O', 'macho'),
('Miloch', 'M', 83, 718, 'O', 'timide'),
('Nessie', 'M', 168, 1721, 'N', 'macho'),
('Tarak', 'F', 123, 851, 'O', 'timide'),
('Solong', 'M', 173, 1481, 'O', 'timide');

INSERT INTO Nourritures (Produit, Calories) VALUES
('pomme', 7),
('cacahuete', 10),
('orange', 25),
('oeuf', 15),
('ver', 3),
('poisson', 35);

INSERT INTO Amours (DragonAimant, DragonAime, Force) VALUES
('Smeagol', 'Tarak', 'passionnement'),
('Birdurh', 'Negueth', 'beaucoup'),
('Negueth', 'Miloch', 'a la folie'),
('Miloch', 'Negueth', 'a la folie'),
('Tarak', 'Bolong', 'un peu'),
('Bolong', 'Tarak', 'beaucoup'),
('Nessie', 'Tarak', 'un peu');

INSERT INTO Repas (Dragon, Produit, Quantite) VALUES
('Smeagol', 'cacahuete', 1000),
('Smeagol', 'pomme', 16),
('Bolong', 'oeuf', 4),
('Negueth', 'orange', 6),
('Negueth', 'oeuf', 1),
('Miloch', 'cacahuete', 100),
('Tarak', 'pomme', 10),
('Tarak', 'orange', 10),
('Solong', 'oeuf', 6),
('Solong', 'orange', 2),
('Miloch', 'ver', 53),
('Nessie', 'poisson', 20),
('Solong', 'poisson', 1);

