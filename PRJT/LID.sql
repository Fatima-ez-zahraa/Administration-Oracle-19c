                                               ----- LID – Requêtes SELECT ------

-- Afficher les postes ouverts --
SELECT titre, statut_poste
FROM postes
WHERE statut_poste = 'Ouvert';

-- Les candidats en "Entretien 1" --
SELECT nom, prenom
FROM candidats
WHERE id_statut = 2;

-- Les postes du département Informatique --
SELECT titre
FROM postes
WHERE id_departement = 1;

-- Candidats triés par date de postulation
SELECT nom, prenom, date_postulation
FROM candidats
ORDER BY date_postulation DESC;

-- Postes les plus récents
SELECT titre, date_publication
FROM postes
ORDER BY date_publication DESC;

-- Candidats + leurs statuts
SELECT c.nom, c.prenom, s.nom_statut
FROM candidats c
JOIN statuts_recrutement s ON c.id_statut = s.id_statut;

-- Entretiens : candidat + poste + recruteur
SELECT c.nom AS candidat, p.titre, r.nom AS recruteur, e.date_entretien
FROM entretiens e
JOIN candidats c ON e.id_candidat = c.id_candidat
JOIN postes p ON e.id_poste = p.id_poste
JOIN recruteurs r ON e.id_recruteur = r.id_recruteur;

-- Candidats + leurs compétences (table N:N)
SELECT c.nom, c.prenom, comp.nom_competence
FROM candidat_competence cc
JOIN candidats c ON cc.id_candidat = c.id_candidat
JOIN competences comp ON cc.id_competence = comp.id_competence
ORDER BY c.nom;

-- Nombre de candidats par statut
SELECT s.nom_statut, COUNT(*) AS total
FROM candidats c
JOIN statuts_recrutement s ON c.id_statut = s.id_statut
GROUP BY s.nom_statut;

-- Score moyen par type de test
SELECT type_test, AVG(score) AS moyenne
FROM tests
GROUP BY type_test;

								-- sous-requete ---
                                
-- Candidats ayant passé un test avec score > moyenne générale
SELECT nom, prenom
FROM candidats
WHERE id_candidat IN (
    SELECT id_candidat
    FROM tests
    WHERE score > (SELECT AVG(score) FROM tests)
);

-- Postes avec le plus grand nombre d’entretiens
/* SELECT titre
FROM postes
WHERE id_poste IN (
    SELECT id_poste
    FROM entretiens
    GROUP BY id_poste
    ORDER BY COUNT(*) DESC
    LIMIT 1
); */
SELECT p.titre
FROM postes p
JOIN (
    SELECT id_poste
    FROM entretiens
    GROUP BY id_poste
    ORDER BY COUNT(*) DESC
    LIMIT 1
) e ON p.id_poste = e.id_poste;

-- Candidats dont le nom contient "a"-----
SELECT * FROM candidats
WHERE nom LIKE '%a%';

-- Compétences commençant par "A"----
SELECT * FROM competences
WHERE nom_competence LIKE 'A%';

-- Les 2 meilleurs scores----
SELECT *
FROM tests
ORDER BY score DESC
LIMIT 2;

-- Les 3 candidats les plus récents
SELECT nom, prenom, date_postulation
FROM candidats
ORDER BY date_postulation DESC
LIMIT 3;

-- Vue : détails complets des entretiens ---
