CREATE TABLE COMMUNE(
	codeCommune INTEGER CONSTRAINT PK_codeCommune PRIMARY KEY,
	nomCommune VARCHAR(30),
	codePostal VARCHAR(5),
	nbHabitants INTEGER CONSTRAINT habitants_positif CHECK (nbHabitants > 0));

CREATE TABLE CAMION(
	numImmat VARCHAR(9) CONSTRAINT PK_numImmat PRIMARY KEY,
	nomProprietaire VARCHAR(30),
	miseEnService DATE);

CREATE TABLE TYPEDECHET(
	codeType VARCHAR(2) CONSTRAINT PK_codeType PRIMARY KEY,
	libelleType VARCHAR(30));
	
CREATE TABLE DEPOT(
	numDepot INTEGER CONSTRAINT PK_numDepot PRIMARY KEY,
	dateDepot DATE,
	heureDepot TIME,
	codeType VARCHAR(2),
	numImmat VARCHAR(9),
	codeCommune INTEGER,
	poidsArrive INTEGER CONSTRAINT arrive_positif CHECK (poidsArrive > 0),
	poidsDepart INTEGER CONSTRAINT depart_positif CHECK (poidsDepart > 0),
	CONSTRAINT FK_codeType FOREIGN KEY (codeType) REFERENCES TYPEDECHET(codeType),
	CONSTRAINT FK_numImmat FOREIGN KEY (numImmat) REFERENCES CAMION(numImmat),
	CONSTRAINT FK_codeCommune FOREIGN KEY (codeCommune) REFERENCES COMMUNE(codeCommune));
	
	
