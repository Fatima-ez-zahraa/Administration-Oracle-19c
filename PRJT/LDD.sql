														-- LDD : Création de la base et des tables --
                                                        
-- =============================
--   CREATION DE LA BASE
-- =============================
CREATE DATABASE IF NOT EXISTS rh;
USE rh;

-- =============================
--   TABLE : DEPARTEMENTS
-- =============================
CREATE TABLE departements (
    id_departement INT AUTO_INCREMENT PRIMARY KEY,
    nom_departement VARCHAR(100) NOT NULL
);

-- =============================
--   TABLE : STATUTS RECRUTEMENT
-- =============================
CREATE TABLE statuts_recrutement (
    id_statut INT AUTO_INCREMENT PRIMARY KEY,
    nom_statut VARCHAR(100) NOT NULL
);

-- =============================
--   TABLE : POSTES
-- =============================
CREATE TABLE postes (
    id_poste INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(150) NOT NULL,
    description TEXT,
    id_departement INT,
    statut_poste ENUM('Ouvert','Fermé') NOT NULL,
    date_publication DATE,
    FOREIGN KEY (id_departement) REFERENCES departements(id_departement)
);

-- =============================
--   TABLE : CANDIDATS
-- =============================
CREATE TABLE candidats (
    id_candidat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150),
    telephone VARCHAR(30),
    id_statut INT,
    date_postulation DATE,
    FOREIGN KEY (id_statut) REFERENCES statuts_recrutement(id_statut)
);

-- =============================
--   TABLE : RECRUTEURS
-- =============================
CREATE TABLE recruteurs (
    id_recruteur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(150)
);

-- =============================
--   TABLE : ENTRETIENS
-- =============================
CREATE TABLE entretiens (
    id_entretien INT AUTO_INCREMENT PRIMARY KEY,
    id_candidat INT,
    id_poste INT,
    id_recruteur INT,
    date_entretien DATETIME,
    type_entretien ENUM('Téléphonique','Technique','RH','Manager'),
    commentaire TEXT,
    FOREIGN KEY (id_candidat) REFERENCES candidats(id_candidat),
    FOREIGN KEY (id_poste) REFERENCES postes(id_poste),
    FOREIGN KEY (id_recruteur) REFERENCES recruteurs(id_recruteur)
);

-- =============================
--   TABLE : TESTS (EVALUATIONS)
-- =============================
CREATE TABLE tests (
    id_test INT AUTO_INCREMENT PRIMARY KEY,
    id_candidat INT,
    type_test ENUM('Technique','Logique','Soft skills'),
    score INT,
    date_test DATE,
    FOREIGN KEY (id_candidat) REFERENCES candidats(id_candidat)
);

-- =============================
--   TABLE : COMPETENCES
-- =============================
CREATE TABLE competences (
    id_competence INT AUTO_INCREMENT PRIMARY KEY,
    nom_competence VARCHAR(100)
);

-- =============================
--   TABLE : CANDIDAT_COMPETENCE (N:N)
-- =============================
CREATE TABLE candidat_competence (
    id_candidat INT,
    id_competence INT,
    PRIMARY KEY (id_candidat, id_competence),
    FOREIGN KEY (id_candidat) REFERENCES candidats(id_candidat),
    FOREIGN KEY (id_competence) REFERENCES competences(id_competence)
);

-- =============================
--   TABLE : CONTRATS
-- =============================
CREATE TABLE contrats (
    id_contrat INT AUTO_INCREMENT PRIMARY KEY,
    id_candidat INT,
    type_contrat ENUM('CDI','CDD','Stage','Freelance'),
    salaire DECIMAL(10,2),
    date_debut DATE,
    date_fin DATE NULL,
    FOREIGN KEY (id_candidat) REFERENCES candidats(id_candidat)
);

--    Requête SQL pour supprimer une colonne --
ALTER TABLE candidats
DROP COLUMN cv;


