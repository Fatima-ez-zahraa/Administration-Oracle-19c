												----- LMD : INSERTIONS  -----

-- =============================
-- INSERT : DEPARTEMENTS
-- =============================
INSERT INTO departements (nom_departement) VALUES
('Informatique'),
('Ressources Humaines'),
('Marketing'),
('Finance'),
('Logistique'),
('Ventes'),
('Direction Générale');


-- =============================
-- INSERT : STATUTS
-- =============================
INSERT INTO statuts_recrutement (nom_statut) VALUES
('En attente'),
('Entretien 1'),
('Entretien 2'),
('Test technique'),
('En délibération'),
('Accepté'),
('Refusé'),
('Contrat signé');


-- =============================
-- INSERT : POSTES
-- =============================
INSERT INTO postes (titre, description, id_departement, statut_poste, date_publication) VALUES
('Développeur Full-Stack', 'Développement web et APIs', 1, 'Ouvert', '2025-01-15'),
('Ingénieur DevOps', 'CI/CD, Docker, Kubernetes', 1, 'Ouvert', '2025-02-05'),
('Responsable RH', 'Gestion du personnel et recrutement', 2, 'Ouvert', '2025-01-20'),
('Chargé Marketing Digital', 'Gestion des campagnes marketing', 3, 'Ouvert', '2025-02-01'),
('Analyste Financier', 'Analyse des états financiers', 4, 'Fermé', '2025-02-01'),
('Assistant Logistique', 'Suivi des livraisons', 5, 'Ouvert', '2025-01-10');


-- =============================
-- INSERT : CANDIDATS
-- =============================
INSERT INTO candidats (nom, prenom, email, telephone, id_statut, date_postulation) VALUES
('El Amrani','Yassine','yassine@gmail.com','0600000000',1,'2025-02-10'),
('Hafidi','Aya','aya@gmail.com','0611111111',2,'2025-02-12'),
('Said','Karim','karim@gmail.com','0622222222',4,'2025-02-15'),
('Bendriss','Fatimaezzahraa','fz@gmail.com','0762214100',1,'2025-02-16'),
('Nouiri','Ismail','ismail@gmail.com','0604444444',3,'2025-02-17'),
('Kanouz','Ikram','ikram@gmail.com','0605555555',1,'2025-02-18'),
('Kharbouch','Adil','adil@gmail.com','0606666666',6,'2025-01-30'),
('Doumal','Imane','imane@gmail.com','0607777777',2,'2025-02-01'),
('Aibi','Youssef','youssef@gmail.com','0608888888',7,'2025-02-05'),
('Bourras','Meryem','meryem@gmail.com','0609999999',1,'2025-02-10');


-- =============================
-- INSERT : RECRUTEURS
-- =============================
INSERT INTO recruteurs (nom, prenom, email) VALUES
('Benkirane','Sara','sara@rh.com'),
('Naji','Mehdi','mehdi@rh.com'),
('Moutazaki','Ikram','ikram@rh.com'),
('Ouchen','Hamza','hamza@rh.com');


-- =============================
-- INSERT : ENTRETIENS
-- =============================
INSERT INTO entretiens (id_candidat, id_poste, id_recruteur, date_entretien, type_entretien, commentaire) VALUES
(1,1,1,'2025-02-18 10:00','Téléphonique','Bon échange'),
(2,1,2,'2025-02-20 14:00','Technique','Compétente'),
(3,5,1,'2025-02-25 11:00','RH','À revoir'),
(4,4,3,'2025-02-26 09:30','Téléphonique','Potentiel intéressant'),
(5,2,2,'2025-02-28 16:00','Technique','Très bon niveau'),
(6,1,1,'2025-03-01 09:00','Technique','Manque d’expérience'),
(7,3,4,'2025-03-03 10:15','RH','Bon profil'),
(8,4,3,'2025-03-04 15:00','Manager','Bonne communication'),
(9,6,1,'2025-03-05 08:30','Téléphonique','Ne correspond pas'),
(10,1,2,'2025-03-06 11:45','Technique','À approfondir');


-- =============================
-- INSERT : TESTS
-- =============================
INSERT INTO tests (id_candidat, type_test, score, date_test) VALUES
(1,'Technique',80,'2025-02-18'),
(2,'Logique',90,'2025-02-20'),
(3,'Soft skills',70,'2025-02-25'),
(4,'Technique',88,'2025-02-27'),
(5,'Technique',95,'2025-02-28'),
(6,'Soft skills',72,'2025-03-01'),
(7,'Logique',65,'2025-03-03'),
(8,'Soft skills',90,'2025-03-04'),
(10,'Technique',77,'2025-03-06');


-- =============================
-- INSERT : COMPETENCES
-- =============================
INSERT INTO competences (nom_competence) VALUES
('Java'),
('SQL'),
('Communication'),
('Analyse financière'),
('Gestion RH'),
('Marketing Digital'),
('Python'),
('Docker'),
('Leadership'),
('Excel avancé');


-- Table associative
INSERT INTO candidat_competence VALUES
(1,1),(1,2),(1,7),(1,8),
(2,3),(2,5),(2,9),
(3,4),(3,10),
(4,6),(4,3),
(5,1),(5,7),(5,8),
(6,3),(6,9),
(7,4),(7,10),
(8,6),(8,3),
(9,3),
(10,1),(10,2),(10,7);


-- =============================
-- INSERT : CONTRATS
-- =============================
INSERT INTO contrats (id_candidat, type_contrat, salaire, date_debut, date_fin) VALUES
(3,'CDI',12000,'2025-03-01', NULL),
(7,'CDD',8000,'2025-02-15','2025-08-15'),
(5,'Stage',3000,'2025-03-10','2025-06-10');

SELECT * FROM tests;

-- Afficher les postes ouvert
SELECT * FROM postes
WHERE statut_poste = 'Ouvert';

-- Afficher les entretiens programmés après une date
SELECT * FROM entretiens
WHERE date_entretien > '2025-02-15';

-- Candidats avec leur statut de recrutement
SELECT c.nom, c.prenom, s.nom_statut
FROM candidats c
JOIN statuts_recrutement s ON c.id_statut = s.id_statut;

-- Candidats avec les postes pour lesquels ils ont passé un entretien
SELECT c.nom, c.prenom, p.titre, e.date_entretien, e.type_entretien
FROM entretiens e
JOIN candidats c ON e.id_candidat = c.id_candidat
JOIN postes p ON e.id_poste = p.id_poste;

-- Candidats + compétences (table associative N:N)
SELECT c.nom, c.prenom, comp.nom_competence
FROM candidat_competence cc
JOIN candidats c ON cc.id_candidat = c.id_candidat
JOIN competences comp ON cc.id_competence = comp.id_competence
ORDER BY c.id_candidat;

-- Recruteurs + entretiens réalisés
SELECT r.nom, r.prenom, e.date_entretien, c.nom AS nom_candidat
FROM entretiens e
JOIN recruteurs r ON e.id_recruteur = r.id_recruteur
JOIN candidats c ON e.id_candidat = c.id_candidat;

-- Tests passés par les candidats
SELECT c.nom, c.prenom, t.type_test, t.score
FROM tests t
JOIN candidats c ON t.id_candidat = c.id_candidat;


											-- Les requetes d'agrégation : 

SELECT COUNT(*) AS total_candidats FROM candidats;

-- Nombre de candidats par statut-----
SELECT s.nom_statut, COUNT(*) AS nb_candidats
FROM candidats c
JOIN statuts_recrutement s ON c.id_statut = s.id_statut
GROUP BY s.nom_statut;

-- Score moyen des tests par type-----
SELECT type_test, AVG(score) AS score_moyen
FROM tests
GROUP BY type_test;

-- Nombre d’entretiens par recruteur
SELECT r.nom, r.prenom, COUNT(*) AS nb_entretiens
FROM entretiens e
JOIN recruteurs r ON e.id_recruteur = r.id_recruteur
GROUP BY r.id_recruteur;

-- Mettre à jour le statut d’un candidat ----
UPDATE candidats
SET id_statut = 4   -- Accepté
WHERE id_candidat = 1;

-- Changer le statut d’un poste ----
UPDATE postes
SET statut_poste = 'Fermé'
WHERE id_poste = 1;

-- Supprimer un candidat----
DELETE FROM candidats
WHERE id_candidat = 3;

-- Supprimer une compétence d’un candidat --
DELETE FROM candidat_competence
WHERE id_candidat = 1 AND id_competence = 2;

												-- Requêtes avancées -----
											
-- Chercher les candidats contenant "a" dans leur nom--
SELECT * FROM candidats
WHERE nom LIKE '%a%';

-- Les 2 meilleurs scores aux tests
SELECT * FROM tests
ORDER BY score DESC
LIMIT 2;

-- Postes publiés entre deux dates ---
SELECT * FROM postes
WHERE date_publication BETWEEN '2025-01-01' AND '2025-02-01';









