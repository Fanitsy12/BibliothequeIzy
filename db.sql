CREATE DATABASE biblio;
\c biblio;

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

CREATE TABLE TypeLivre (
    IdTypeLivre SERIAL PRIMARY KEY,
    Type VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO TypeLivre (Type) VALUES
('Roman'),
('Essai'),
('Science'),
('Informatique'),
('Histoire');

CREATE TABLE Livre (
    IdLivre SERIAL PRIMARY KEY,
    Titre VARCHAR(255) NOT NULL,
    Auteur VARCHAR(255),
    DateEdition DATE,
    IdTypeLivre INTEGER REFERENCES TypeLivre(IdTypeLivre),
    Status VARCHAR(20) NOT NULL DEFAULT 'disponible' CHECK (Status IN ('disponible', 'emprunté', 'perdu', 'en réparation'))
);
ALTER TABLE Livre
ADD COLUMN restriction_age INTEGER;
ALTER table Livre 
ADD COLUMN Status VARCHAR(20) NOT NULL DEFAULT 'disponible' CHECK (Status IN ('disponible', 'emprunté', 'perdu', 'en réparation'));

INSERT INTO Livre (Titre, Auteur, DateEdition, IdTypeLivre, Status) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupéry', '1943-04-06', 1, 'disponible'),
('LArt de la Guerre', 'Sun Tzu', '1910-01-01', 2, 'disponible'),
('Introduction à Java', 'James Gosling', '2010-09-15', 4, 'emprunté'),
('LOrigine des espèces', 'Charles Darwin', '1859-11-24', 3, 'perdu'),
('La Révolution Française', 'Jules Michelet', '1847-01-01', 5, 'en réparation');
ALTER TABLE Livre
set restriction_age=15 where id/2=0;

CREATE TABLE ExemplaireLivre (
    IdExemplaireLivre SERIAL PRIMARY KEY,
    IdLivre INTEGER NOT NULL REFERENCES Livre(IdLivre),
    CodeBarre VARCHAR(50) UNIQUE,
    DateAcquisition DATE DEFAULT CURRENT_DATE,
    Etat VARCHAR(20) DEFAULT 'bon' CHECK (Etat IN ('bon', 'moyen', 'mauvais', 'hors service')),
    Status INT DEFAULT 1 CHECK (Status IN (0, 1))
);
INSERT INTO ExemplaireLivre (IdLivre, CodeBarre, DateAcquisition, Etat, Status) VALUES
(1, 'EX001', '2020-01-01', 'bon', 1),
(1, 'EX002', '2021-06-01', 'moyen', 1),
(2, 'EX003', '2022-03-12', 'bon', 1),
(3, 'EX004', '2022-08-25', 'mauvais', 0),
(4, 'EX005', '2019-11-05', 'hors service', 0),
(5, 'EX006', '2023-01-10', 'bon', 1);

CREATE TABLE CategorieLivre (
    IdCatLivre SERIAL PRIMARY KEY,
    Categorie VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO CategorieLivre (Categorie) VALUES
('Philosophie'),
('Science Fiction'),
('Education'),
('Biographie'),
('Politique');

CREATE TABLE LivreCategorie (
    IdCatLivre INTEGER NOT NULL REFERENCES CategorieLivre(IdCatLivre),
    IdLivre INTEGER NOT NULL REFERENCES Livre(IdLivre),
    PRIMARY KEY (IdCatLivre, IdLivre)
);
INSERT INTO LivreCategorie (IdCatLivre, IdLivre) VALUES
(1, 2),
(2, 1), 
(3, 3), 
(4, 5), 
(5, 5); 


CREATE TABLE Pret (
    IdPret SERIAL PRIMARY KEY,
    TypePret VARCHAR(20) NOT NULL  CHECK (TypePret IN ( 'sur_place', 'a_domicile')),
    Date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    Date_rendu DATE,
    Date_rendu_prevue DATE NOT NULL,
    is_prolonged BOOLEAN DEFAULT FALSE,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    IdExemplaireLivre INTEGER NOT NULL REFERENCES ExemplaireLivre(IdExemplaireLivre),
    CONSTRAINT check_dates CHECK (Date_rendu IS NULL OR Date_rendu >= Date_emprunt)
);
CREATE TABLE Penalite (
    IdPenalite SERIAL PRIMARY KEY,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    IdPret INTEGER REFERENCES Pret(IdPret),
    DateDebutPenalite DATE NOT NULL DEFAULT CURRENT_DATE,
    DatelevePenalite DATE NOT NULL DEFAULT CURRENT_DATE
);
ALTER TABLE Penalite ADD COLUMN Leve BOOLEAN NOT NULL DEFAULT FALSE;

CREATE TABLE adherent_quota ( 
    id_adherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent)  ,
    quota_surplace INTEGER NOT NULL DEFAULT 0,
    quota_emprunter INTEGER NOT NULL DEFAULT 0,      
);
CREATE TABLE Reservation (
    idReservation SERIAL PRIMARY KEY,
    idAdherent INT NOT NULL REFERENCES Adherent(idAdherent),
    idLivre INT NOT NULL REFERENCES Livre(idLivre),
    idExemplaireLivre INT REFERENCES ExemplaireLivre(idExemplaireLivre),
    date_reservation DATE NOT NULL DEFAULT CURRENT_DATE,
    date_debut_reservation DATE,
      date_fin_reservation DATE,

    isApproved BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_livre_titre ON Livre(Titre);
CREATE INDEX idx_livre_auteur ON Livre(Auteur);
CREATE INDEX idx_pret_user ON Pret(IdAdherent);
CREATE INDEX idx_pret_exemplaire ON Pret(IdExemplaireLivre);
CREATE INDEX idx_pret_dates ON Pret(Date_emprunt, Date_rendu);
CREATE INDEX idx_user_profil ON Adherent(Id_Profil);


CREATE TABLE Users (
    IdUser SERIAL PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Prenom VARCHAR(100),
    Mdp VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    DateNaissance DATE,
    Id_Profil INTEGER NOT NULL REFERENCES Profil(Id_Profil)
);
INSERT INTO Users (Nom, Prenom, Mdp, Email, DateNaissance, Id_Profil)
VALUES ('admin', 'super', 'admin123', 'admin@gmail.com', '1990-01-01', 3);

CREATE TABLE Pret_Prolongement (
    idProlongement SERIAL PRIMARY KEY,
    idPret INTEGER NOT NULL REFERENCES Pret(idPret),
    jour_prolongement INTEGER NOT NULL CHECK (jour_prolongement BETWEEN 1 AND 15),
    est_valide BOOLEAN DEFAULT FALSE
);


INSERT INTO Livre (Titre, Auteur, DateEdition, IdTypeLivre, Status, restriction_age) VALUES
('Le Petit Prince', 'Antoine de Saint-Exupery', '1943-04-06', 1, 'disponible', 0),
('L''Art de la Guerre', 'Sun Tzu', '1910-01-01', 1, 'disponible', 12), 
('Introduction a Java', 'James Gosling', '2010-09-15', 1, 'emprunte', 16), 
('L''Origine des especes', 'Charles Darwin', '1859-11-24', 1, 'perdu', 18), 
('La Revolution Francaise', 'Jules Michelet', '1847-01-01', 5, 'en reparation', 0),
('Harry Potter a l''Ecole des Sorciers', 'J.K. Rowling', '1997-06-26', 1, 'disponible', 10),
('Le Seigneur des Anneaux', 'J.R.R. Tolkien', '1954-07-29', 1, 'disponible', 14),
('Le Guide du developpeur Python', 'Guido van Rossum', '2015-03-01', 1, 'disponible', 16), 
('Histoire de la Philosophie', 'Platon', '2000-01-01', 1, 'emprunte', 18), 
('Atlas du Monde', 'National Geographic', '2018-11-10', 1, 'disponible', 0); 