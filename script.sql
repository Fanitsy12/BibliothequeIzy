CREATE TABLE Profil (
    Id_Profil SERIAL PRIMARY KEY,
    Nom_Profil VARCHAR(50) NOT NULL,
    Quota_maxSurPlace INTEGER NOT NULL,
    Quota_maxEmprunter INTEGER,
    Duree_pret INTEGER NOT NULL
);
ALTER TABLE Profil ADD COLUMN Duree_penalite INTEGER DEFAULT 0;
INSERT INTO Profil (Nom_Profil, Quota_maxSurPlace, Quota_maxEmprunter, Duree_pret) VALUES
('Etudiant',4, 2, 15),
('Enseignant', 6, 4, 30),
('Administrateur', 10, 10, 60),
('Visiteur', 2, 0, 0);
CREATE TABLE Adherent (
    IdAdherent SERIAL PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Prenom VARCHAR(100),
    DateNaissance DATE,
    Email VARCHAR(100),
    MotDePasse VARCHAR(10),
    Date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,
    Id_Profil INTEGER NOT NULL REFERENCES Profil(Id_Profil)
);

CREATE TABLE Abonnement (
    IdAbonnement SERIAL PRIMARY KEY,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    Datedebut DATE NOT NULL DEFAULT CURRENT_DATE,
    DateFin DATE NOT NULL DEFAULT CURRENT_DATE,
    Montant DECIMAL(10,2) NOT NULL CHECK (Montant >= 0),
);
CREATE TABLE Penalite (
    IdPenalite SERIAL PRIMARY KEY,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    IdPret INTEGER REFERENCES Pret(IdPret),
    DateDebutPenalite DATE NOT NULL DEFAULT CURRENT_DATE,
    DatelevePenalite DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE TABLE adherent_quota ( 
    id_adherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent)  ,
    quota_surplace INTEGER NOT NULL DEFAULT 0,
    quota_emprunter INTEGER NOT NULL DEFAULT 0,      
);