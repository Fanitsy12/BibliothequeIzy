-- Base de données Bibliothèque - Version propre
CREATE DATABASE biblio;
\c biblio;

-- Table des profils d'utilisateurs
CREATE TABLE Profil (
    Id_Profil SERIAL PRIMARY KEY,
    Nom_Profil VARCHAR(50) NOT NULL,
    Quota_maxSurPlace INTEGER NOT NULL,
    Quota_maxEmprunter INTEGER,
    Duree_pret INTEGER NOT NULL,
    Duree_penalite INTEGER DEFAULT 0
);

-- Table des adhérents
CREATE TABLE Adherent (
    IdAdherent SERIAL PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Prenom VARCHAR(100),
    DateNaissance DATE,
    Email VARCHAR(100),
    MotDePasse VARCHAR(255),
    Date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,
    Id_Profil INTEGER NOT NULL REFERENCES Profil(Id_Profil)
);

-- Table des abonnements
CREATE TABLE Abonnement (
    IdAbonnement SERIAL PRIMARY KEY,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    Datedebut DATE NOT NULL DEFAULT CURRENT_DATE,
    DateFin DATE NOT NULL,
    Montant DECIMAL(10,2) NOT NULL CHECK (Montant >= 0)
);

-- Table des types de livres
CREATE TABLE TypeLivre (
    IdTypeLivre SERIAL PRIMARY KEY,
    Type VARCHAR(50) NOT NULL UNIQUE
);

-- Table des livres
CREATE TABLE Livre (
    IdLivre SERIAL PRIMARY KEY,
    Titre VARCHAR(255) NOT NULL,
    Auteur VARCHAR(255),
    DateEdition DATE,
    IdTypeLivre INTEGER REFERENCES TypeLivre(IdTypeLivre),
    Status VARCHAR(20) NOT NULL DEFAULT 'disponible' CHECK (Status IN ('disponible', 'emprunté', 'perdu', 'en réparation')),
    restriction_age INTEGER DEFAULT 0
);

-- Table des exemplaires de livres
CREATE TABLE ExemplaireLivre (
    IdExemplaireLivre SERIAL PRIMARY KEY,
    IdLivre INTEGER NOT NULL REFERENCES Livre(IdLivre),
    CodeBarre VARCHAR(50) UNIQUE,
    DateAcquisition DATE DEFAULT CURRENT_DATE,
    Etat VARCHAR(20) DEFAULT 'bon' CHECK (Etat IN ('bon', 'moyen', 'mauvais', 'hors service')),
    Status INTEGER DEFAULT 1 CHECK (Status IN (0, 1))
);

-- Table des catégories de livres
CREATE TABLE CategorieLivre (
    IdCatLivre SERIAL PRIMARY KEY,
    Categorie VARCHAR(50) NOT NULL UNIQUE
);

-- Table de liaison livre-catégorie
CREATE TABLE LivreCategorie (
    IdCatLivre INTEGER NOT NULL REFERENCES CategorieLivre(IdCatLivre),
    IdLivre INTEGER NOT NULL REFERENCES Livre(IdLivre),
    PRIMARY KEY (IdCatLivre, IdLivre)
);

-- Table des prêts
CREATE TABLE Pret (
    IdPret SERIAL PRIMARY KEY,
    TypePret VARCHAR(20) NOT NULL CHECK (TypePret IN ('sur_place', 'a_domicile')),
    Date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    Date_rendu DATE,
    Date_rendu_prevue DATE NOT NULL,
    is_prolonged BOOLEAN DEFAULT FALSE,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    IdExemplaireLivre INTEGER NOT NULL REFERENCES ExemplaireLivre(IdExemplaireLivre),
    CONSTRAINT check_dates CHECK (Date_rendu IS NULL OR Date_rendu >= Date_emprunt)
);

-- Table des pénalités
CREATE TABLE Penalite (
    IdPenalite SERIAL PRIMARY KEY,
    IdAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    IdPret INTEGER REFERENCES Pret(IdPret),
    DateDebutPenalite DATE NOT NULL DEFAULT CURRENT_DATE,
    DatelevePenalite DATE,
    Leve BOOLEAN NOT NULL DEFAULT FALSE
);

-- Table des quotas d'adhérents
CREATE TABLE adherent_quota (
    id_adherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    quota_surplace INTEGER NOT NULL DEFAULT 0,
    quota_emprunter INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id_adherent)
);

-- Table des réservations
CREATE TABLE Reservation (
    idReservation SERIAL PRIMARY KEY,
    idAdherent INTEGER NOT NULL REFERENCES Adherent(IdAdherent),
    idLivre INTEGER NOT NULL REFERENCES Livre(IdLivre),
    idExemplaireLivre INTEGER REFERENCES ExemplaireLivre(IdExemplaireLivre),
    date_reservation DATE NOT NULL DEFAULT CURRENT_DATE,
    date_debut_reservation DATE,
    date_fin_reservation DATE,
    isApproved BOOLEAN DEFAULT FALSE
);

-- Table des utilisateurs (système)
CREATE TABLE Users (
    IdUser SERIAL PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Prenom VARCHAR(100),
    Mdp VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    DateNaissance DATE,
    Id_Profil INTEGER NOT NULL REFERENCES Profil(Id_Profil)
);

-- Table des prolongements de prêts
CREATE TABLE Pret_Prolongement (
    idProlongement SERIAL PRIMARY KEY,
    idPret INTEGER NOT NULL REFERENCES Pret(idPret),
    jour_prolongement INTEGER NOT NULL CHECK (jour_prolongement BETWEEN 1 AND 15),
    est_valide BOOLEAN DEFAULT FALSE
);

-- Index pour optimiser les performances
CREATE INDEX idx_livre_titre ON Livre(Titre);
CREATE INDEX idx_livre_auteur ON Livre(Auteur);
CREATE INDEX idx_pret_user ON Pret(IdAdherent);
CREATE INDEX idx_pret_exemplaire ON Pret(IdExemplaireLivre);
CREATE INDEX idx_pret_dates ON Pret(Date_emprunt, Date_rendu);
CREATE INDEX idx_user_profil ON Adherent(Id_Profil);