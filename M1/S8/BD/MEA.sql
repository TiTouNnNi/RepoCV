DROP TABLE Population;
DROP TABLE Deces;
DROP Table Naissance;
DROP TABLE Commune CASCADE;
DROP TABLE Departement;
DROP TABLE Region;

CREATE TABLE Region(
   codeRegion INT ,
   PRIMARY KEY(codeRegion)
);


CREATE TABLE Departement(
   codeDepartement VARCHAR(3) ,
   codeRegion INT NOT NULL,
   PRIMARY KEY(codeDepartement),
   FOREIGN KEY(codeRegion) REFERENCES Region(codeRegion)
);


CREATE TABLE Commune(
   codeCommune VARCHAR(5) ,
   superficie DECIMAL(15,2),
   nomCommune VARCHAR(50),
   codeDepartement VARCHAR(3) NOT NULL,
   PRIMARY KEY(codeCommune),
   FOREIGN KEY(codeDepartement) REFERENCES Departement(codeDepartement)
);


CREATE TABLE Naissance(
   idNaissance SERIAL ,
   anneeDebutNaissance VARCHAR(9),
   valeurNaissance INT ,
   anneeFinNaissance VARCHAR(50),
   codeCommune VARCHAR(5) NOT NULL,
   PRIMARY KEY(idNaissance),
   FOREIGN KEY(codeCommune) REFERENCES Commune(codeCommune)
);


CREATE TABLE Deces(
   idDeces SERIAL ,
   anneeDebutDeces DATE,
   anneeFinDeces DATE,
   valeurDeces INT ,
   codeCommune VARCHAR(5) NOT NULL,
   PRIMARY KEY(idDeces),
   FOREIGN KEY(codeCommune) REFERENCES Commune(codeCommune)
);


CREATE TABLE Population(
   idPopulation SERIAL ,
   annee DATE,
   valeurPopulation INT ,
   codeCommune VARCHAR(5) NOT NULL,
   PRIMARY KEY(idPopulation),
   FOREIGN KEY(codeCommune) REFERENCES Commune(codeCommune)
);
