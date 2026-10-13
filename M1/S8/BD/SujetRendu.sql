DROP TABLE IF EXISTS Statistique CASCADE;
DROP TABLE IF EXISTS StatType CASCADE;
DROP TABLE IF EXISTS Commune CASCADE;
DROP TABLE IF EXISTS Departement CASCADE;
DROP TABLE IF EXISTS Region CASCADE;

CREATE TABLE Region(
  idRegion SERIAL NOT NULL CONSTRAINT PK_idRegion PRIMARY KEY,
  nomRegion VARCHAR(50),
  idChefLieu INT
  );
  
 CREATE TABLE Departement(
   idDepartement SERIAL NOT NULL CONSTRAINT PK_idDepartement PRIMARY KEY,
   nomDepartement VARCHAR(50),
   idRegion INT NOT NULL,
   idChefLieu INT,
   CONSTRAINT FK_idRegion FOREIGN KEY (idRegion) REFERENCES Region(idRegion)
   );
   
CREATE TABLE Commune(
  idCommune SERIAL NOT NULL CONSTRAINT PK_idCommune PRIMARY KEY,
  nomCommune VARCHAR(50),
  idDepartement INT NOT NULL,
  CONSTRAINT FK_idDepartement FOREIGN KEY (idDepartement) REFERENCES Departement(idDepartement)
  );
  
ALTER TABLE Region
  ADD CONSTRAINT FK_idChefLieuRegion FOREIGN KEY (idChefLieu) REFERENCES Commune(idCommune);
  
 ALTER TABLE Departement
  ADD CONSTRAINT FK_idChefLieuDepartement FOREIGN KEY (idChefLieu) REFERENCES Commune(idCommune);
  
CREATE TABLE StatType(
  idStatType SERIAL CONSTRAINT PK_idStatType PRIMARY KEY,
  codeStat VARCHAR(50) UNIQUE,
  description VARCHAR(255)
  );
  
CREATE TABLE Statistique(
  idStat SERIAL CONSTRAINT PK_idStat PRIMARY KEY,
  idStatType INT NOT NULL,
  idCommune INT NOT NULL,
  valeur INT NOT NULL,
  dateDebut DATE,
  dateFin DATE,
  CONSTRAINT FK_idStatType FOREIGN KEY (idStatType) REFERENCES StatType(idStatType),
  CONSTRAINT FK_idCommune FOREIGN KEY (idCommune) REFERENCES Commune(idCommune)
  );
  
