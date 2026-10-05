-- ---------------------------------------------------------------------
-- 1. Comptes de connexion
-- ---------------------------------------------------------------------
INSERT INTO users (role, email, password_hash) VALUES
  ('direction',   'direction@esperance.be',      '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 1
  ('secretariat', 'secretariat@esperance.be',    '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 2
  ('enseignant',  'm.dubois@esperance.be',       '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 3
  ('enseignant',  's.lambert@esperance.be',      '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 4
  ('enseignant',  't.mertens@esperance.be',      '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 5
  ('paramedical', 'c.gilson@esperance.be',       '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 6
  ('paramedical', 'p.renard@esperance.be',       '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 7
  ('tuteur',      'j.dupont@gmail.com',          '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 8
  ('tuteur',      'a.lemaire@gmail.com',         '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 9
  ('tuteur',      'k.benali@hotmail.com',        '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 10
  ('eleve',       'lea.dupont@esperance.be',     '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 11
  ('eleve',       'noah.lemaire@esperance.be',   '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'), -- id 12
  ('eleve',       'ines.benali@esperance.be',    '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm'); -- id 13

-- Un compte désactivé, pour tester le refus de connexion
INSERT INTO users (role, email, password_hash, actif) VALUES
  ('enseignant',  'ancien.prof@esperance.be',    '$2b$10$y48mv3QaaWWvQeNmCCFzQO16vypLlsx8FeOlBKKQyE3R1/iGccAHm', FALSE); -- id 14


-- ---------------------------------------------------------------------
-- 2. Acteurs
-- ---------------------------------------------------------------------
INSERT INTO direction (nom, prenom, adresse, mail, date_naissance, telephone, poste, id_user) VALUES
  ('Delvaux', 'Catherine', 'Rue de la Station 12, 7060 Soignies', 'direction@esperance.be', '1972-04-18', '067 33 12 45', 'Directrice', 1),        -- id 1
  ('Hanot',   'Philippe',  'Chaussée de Mons 88, 7060 Soignies', 'p.hanot@esperance.be',   '1978-11-02', '067 33 12 46', 'Sous-directeur', NULL); -- id 2

INSERT INTO secretariat (nom, prenom, adresse, mail, date_naissance, telephone, poste, id_user) VALUES
  ('Leclercq', 'Nathalie', 'Rue des Carrières 5, 7060 Soignies', 'secretariat@esperance.be', '1985-06-09', '067 33 12 40', 'Secrétaire de direction', 2), -- id 1
  ('Collard',  'Julien',   'Avenue Wauters 31, 7070 Le Roeulx',  'j.collard@esperance.be',   '1991-01-23', '067 33 12 41', 'Secrétaire administratif', NULL); -- id 2

INSERT INTO enseignant (nom, prenom, adresse, mail, date_naissance, poste, local_, id_user) VALUES
  ('Dubois',  'Marie',   'Rue Neuve 14, 7000 Mons',             'm.dubois@esperance.be',  '1984-03-12', 'Titulaire',           'A01', 3),    -- id 1
  ('Lambert', 'Sophie',  'Rue du Parc 7, 7060 Soignies',        's.lambert@esperance.be', '1989-09-27', 'Titulaire',           'A02', 4),    -- id 2
  ('Mertens', 'Thomas',  'Rue de Bruxelles 102, 7100 La Louvière','t.mertens@esperance.be','1980-12-05', 'Titulaire',           'B01', 5),    -- id 3
  ('Wauthier','Olivier', 'Grand-Place 3, 7060 Soignies',        'o.wauthier@esperance.be','1975-07-19', 'Maître d''éducation physique', 'Salle de sport', NULL), -- id 4
  ('Ancien',  'Prof',    'Rue de l''Église 1, 7060 Soignies',   'ancien.prof@esperance.be','1966-02-14', 'Titulaire',           NULL, 14);    -- id 5

INSERT INTO personnel_paramedical (nom, prenom, date_naissance, adresse, mail, profession, local_, id_user) VALUES
  ('Gilson', 'Claire', '1987-05-30', 'Rue Grégoire Decorte 9, 7070 Le Roeulx', 'c.gilson@esperance.be', 'Logopède',      'P01', 6),    -- id 1
  ('Renard', 'Pierre', '1982-08-11', 'Rue Mademoiselle Hanicq 20, 7060 Soignies', 'p.renard@esperance.be', 'Kinésithérapeute', 'P02', 7), -- id 2
  ('Moreau', 'Aline',  '1990-10-03', 'Boulevard Dolez 45, 7000 Mons',         'a.moreau@esperance.be', 'Psychologue',   'P03', NULL); -- id 3

INSERT INTO tuteur_legal (nom, prenom, adresse, mail, date_naissance, telephone, lien, id_user) VALUES
  ('Dupont',  'Jean',    'Rue de la Station 40, 7060 Soignies',   'j.dupont@gmail.com',    '1985-02-17', '0475 12 34 56', 'Père',  8),    -- id 1
  ('Lemaire', 'Aurélie', 'Rue Henri Leroy 8, 7060 Soignies',      'a.lemaire@gmail.com',   '1988-07-04', '0486 22 33 44', 'Mère',  9),    -- id 2
  ('Benali',  'Karim',   'Rue de Mons 61, 7070 Le Roeulx',        'k.benali@hotmail.com',  '1983-11-29', '0497 55 66 77', 'Père',  10),   -- id 3
  ('Petit',   'Isabelle','Chaussée du Roeulx 150, 7000 Mons',     'i.petit@skynet.be',     '1979-04-08', '0478 98 76 54', 'Mère',  NULL), -- id 4
  ('Gérard',  'Marc',    'Rue Chanoine Scarmure 3, 7060 Soignies','m.gerard@outlook.be',   '1965-09-15', '0472 11 22 33', 'Tuteur', NULL); -- id 5


-- ---------------------------------------------------------------------
-- 3. Structure pédagogique
-- ---------------------------------------------------------------------
INSERT INTO niveau (nom_niveau) VALUES
  ('P1'), ('P2'), ('P3'), ('P4'), ('P5'), ('P6');   -- id 1 à 6

INSERT INTO matiere (nom, heures, description_) VALUES
  ('Français',           6, 'Lecture, écriture, expression orale'),       -- id 1
  ('Mathématiques',      5, 'Nombres, grandeurs, géométrie, traitement de données'), -- id 2
  ('Éveil',              3, 'Sciences, histoire et géographie'),         -- id 3
  ('Éducation physique', 2, NULL),                                        -- id 4
  ('Psychomotricité',    2, 'Coordination, schéma corporel, latéralité'); -- id 5

INSERT INTO programme (nom_programme, annee_scolaire, description_, id_niveau) VALUES
  ('Cycle 1 : P1-P2', '2026-2027', 'Apprentissages de base, lecture et calcul', 1), -- id 1
  ('Cycle 2 : P3-P4', '2026-2027', 'Consolidation des apprentissages',          3), -- id 2
  ('Cycle 3 : P5-P6', '2026-2027', 'Préparation au CEB adaptée',                 5); -- id 3

INSERT INTO programme_matiere (id_programme, id_matiere, coefficient) VALUES
  (1, 1, 3), (1, 2, 3), (1, 3, 1), (1, 4, 1), (1, 5, 2),
  (2, 1, 3), (2, 2, 3), (2, 3, 2), (2, 4, 1), (2, 5, 1),
  (3, 1, 3), (3, 2, 3), (3, 3, 2), (3, 4, 1);

INSERT INTO classe (nom_classe, tranche_age, capacite, id_programme, id_enseignant) VALUES
  ('P1A', '6-7 ans',   8, 1, 1),   -- id 1
  ('P2A', '7-8 ans',   8, 1, 2),   -- id 2
  ('P3A', '8-9 ans',  10, 2, 3),   -- id 3
  ('P5A', '10-11 ans',10, 3, NULL);-- id 4  (pas encore de titulaire)

INSERT INTO eleve (nom, prenom, adresse, mail, date_naissance, type_, id_classe, id_tuteur, id_user) VALUES
  ('Dupont',  'Léa',     'Rue de la Station 40, 7060 Soignies',   'lea.dupont@esperance.be',   '2019-05-14', 'type 8', 1, 1, 11),   -- id 1
  ('Lemaire', 'Noah',    'Rue Henri Leroy 8, 7060 Soignies',      'noah.lemaire@esperance.be', '2018-03-22', 'type 1', 2, 2, 12),   -- id 2
  ('Benali',  'Inès',    'Rue de Mons 61, 7070 Le Roeulx',        'ines.benali@esperance.be',  '2017-10-09', 'type 2', 3, 3, 13),   -- id 3
  ('Benali',  'Yanis',   'Rue de Mons 61, 7070 Le Roeulx',        'k.benali@hotmail.com',      '2019-12-01', 'type 8', 1, 3, NULL), -- id 4
  ('Petit',   'Emma',    'Chaussée du Roeulx 150, 7000 Mons',     'i.petit@skynet.be',         '2018-08-17', 'type 1', 2, 4, NULL), -- id 5
  ('Petit',   'Lucas',   'Chaussée du Roeulx 150, 7000 Mons',     'i.petit@skynet.be',         '2016-02-26', 'type 8', 4, 4, NULL), -- id 6
  ('Gérard',  'Mila',    'Rue Chanoine Scarmure 3, 7060 Soignies','m.gerard@outlook.be',       '2017-06-30', 'type 2', 3, 5, NULL), -- id 7
  ('Dupont',  'Hugo',    'Rue de la Station 40, 7060 Soignies',   'j.dupont@gmail.com',        '2016-11-11', 'type 1', 4, 1, NULL), -- id 8
  ('Lemaire', 'Chloé',   'Rue Henri Leroy 8, 7060 Soignies',      'a.lemaire@gmail.com',       '2019-01-19', NULL,     1, 2, NULL), -- id 9  (type pas encore déterminé)
  ('Gérard',  'Adam',    'Rue Chanoine Scarmure 3, 7060 Soignies','m.gerard@outlook.be',       '2018-09-05', 'type 8', NULL, 5, NULL); -- id 10 (pas encore dans une classe)


-- ---------------------------------------------------------------------
-- 4. Évaluations et suivi pédagogique
-- ---------------------------------------------------------------------
INSERT INTO periode (nom, date_debut, date_fin, coefficient) VALUES
  ('Trimestre 1', '2026-08-26', '2026-12-18', 1),  -- id 1
  ('Trimestre 2', '2027-01-04', '2027-03-26', 1),  -- id 2
  ('Trimestre 3', '2027-04-12', '2027-07-02', 2);  -- id 3

INSERT INTO evaluation (coefficient, type_evaluation, date_evaluation, id_matiere, id_periode) VALUES
  (1, 'controle', '2026-09-18', 1, 1),  -- id 1  Français
  (1, 'controle', '2026-09-25', 2, 1),  -- id 2  Maths
  (1, 'devoir',   '2026-10-02', 3, 1),  -- id 3  Éveil
  (2, 'projet',   '2026-11-20', 3, 1),  -- id 4  Éveil (à venir)
  (3, 'examen',   '2026-12-10', 1, 1),  -- id 5  Français (à venir)
  (3, 'examen',   '2026-12-11', 2, 1);  -- id 6  Maths (à venir)

-- Notes sur 20, uniquement pour les évaluations déjà passées
INSERT INTO resultat (id_evaluation, id_eleve, note, commentaire) VALUES
  (1, 1, 14.50, 'Bonne lecture, progrès en écriture'),
  (1, 2, 11.00, NULL),
  (1, 3, 16.00, 'Très bon travail'),
  (1, 4,  9.50, 'Encore des difficultés avec les sons complexes'),
  (1, 5, 12.00, NULL),
  (2, 1, 13.00, NULL),
  (2, 2, 15.50, 'Calcul mental en progrès'),
  (2, 3, 17.00, NULL),
  (2, 4, 10.00, NULL),
  (2, 5,  8.50, 'Revoir les tables d''addition'),
  (3, 3, 15.00, NULL),
  (3, 6, 12.50, NULL),
  (3, 7, 14.00, NULL),
  (3, 8, 11.50, 'Travail rendu en retard');

INSERT INTO conseil_de_classe (date_conseil, id_periode) VALUES
  ('2026-12-15', 1);   -- id 1

INSERT INTO conseil_eleve (id_conseil, id_eleve, ressources, difficultes, objectifs) VALUES
  (1, 1, 'Motivée, bonne participation orale',  'Écriture encore hésitante',       'Gagner en autonomie à l''écrit'),
  (1, 2, 'Bon raisonnement logique',            'Concentration sur la durée',      'Travailler par séquences courtes'),
  (1, 4, 'Curieux, aime manipuler',             'Lecture des sons complexes',      'Suivi logopédique renforcé');


-- ---------------------------------------------------------------------
-- 5. Suivi paramédical
-- ---------------------------------------------------------------------
INSERT INTO intervention (type_intervention, frequence, id_paramedical) VALUES
  ('Séance de logopédie',    'Hebdomadaire', 1),  -- id 1
  ('Séance de kinésithérapie','Bihebdomadaire', 2), -- id 2
  ('Suivi psychologique',    'Mensuel',      3);  -- id 3

INSERT INTO visite (id_intervention, id_eleve, date_visite, etat_visite) VALUES
  (1, 1, '2026-09-15', 'réalisée'),
  (1, 1, '2026-09-22', 'réalisée'),
  (1, 4, '2026-09-22', 'réalisée'),
  (1, 4, '2026-09-29', 'annulée'),
  (1, 4, '2026-10-06', 'prévue'),
  (2, 2, '2026-09-17', 'réalisée'),
  (2, 2, '2026-10-01', 'réalisée'),
  (2, 7, '2026-10-08', 'prévue'),
  (3, 5, '2026-09-24', 'réalisée'),
  (3, 5, '2026-10-22', 'prévue');


-- ---------------------------------------------------------------------
-- 6. Vie scolaire et activités
-- ---------------------------------------------------------------------
INSERT INTO absence (id_eleve, date_, statut) VALUES
  (2, '2026-09-08', 'justifié'),
  (2, '2026-09-09', 'justifié'),
  (4, '2026-09-21', 'retard'),
  (5, '2026-09-28', 'absent'),
  (8, '2026-10-01', 'absent'),
  (1, '2026-10-02', 'retard');

INSERT INTO activite_extra (nom, lieu, description_, date_activite, cout) VALUES
  ('Visite de la ferme pédagogique', 'Ferme du Bois de la Lance, Soignies', 'Découverte des animaux et des métiers de la ferme', '2026-10-16', 8.00),  -- id 1
  ('Piscine',                         'Piscine communale de Soignies',      'Séance d''accoutumance à l''eau',                  '2026-11-06', 3.50),  -- id 2
  ('Spectacle de Saint-Nicolas',      'Salle polyvalente de l''école',      NULL,                                                '2026-12-04', 0.00);  -- id 3

INSERT INTO prof_acti (id_enseignant, id_activite, statut, commentaire) VALUES
  (1, 1, 'responsable',    'Organise le transport en car'),
  (2, 1, 'accompagnateur', NULL),
  (4, 2, 'responsable',    NULL),
  (3, 3, 'accompagnateur', NULL);

INSERT INTO presence_activite (id_eleve, id_activite, statut, paiement) VALUES
  (1, 1, 'inscrit', TRUE),
  (4, 1, 'inscrit', TRUE),
  (9, 1, 'inscrit', FALSE),
  (2, 1, 'inscrit', TRUE),
  (5, 1, 'inscrit', FALSE),
  (3, 2, 'inscrit', TRUE),
  (7, 2, 'inscrit', TRUE),
  (1, 3, 'inscrit', TRUE),
  (2, 3, 'inscrit', TRUE);

INSERT INTO reunion (date_reunion, commentaire, id_direction) VALUES
  ('2026-09-02', 'Réunion de rentrée : organisation de l''année', 1),  -- id 1
  ('2026-10-14', 'Préparation des PIA du premier trimestre',      1);  -- id 2

INSERT INTO presence_reunion (id_enseignant, id_reunion, statut, commentaire) VALUES
  (1, 1, 'présent', NULL),
  (2, 1, 'présent', NULL),
  (3, 1, 'excusé',  'Formation continuée'),
  (4, 1, 'présent', NULL),
  (1, 2, 'convoqué', NULL),
  (2, 2, 'convoqué', NULL),
  (3, 2, 'convoqué', NULL);


-- ---------------------------------------------------------------------
-- 7. Administration et fournitures
-- ---------------------------------------------------------------------
INSERT INTO inscription (date_inscription, total_paye, statut_paiement, id_eleve, id_secretaire) VALUES
  ('2026-06-20', 45.00, 'payé',       1, 1),
  ('2026-06-22', 45.00, 'payé',       2, 1),
  ('2026-06-25', 45.00, 'payé',       3, 2),
  ('2026-06-25', 45.00, 'payé',       4, 2),
  ('2026-08-24', 20.00, 'partiel',    5, 1),
  ('2026-08-24', 45.00, 'payé',       6, 1),
  ('2026-08-27', 45.00, 'payé',       7, 2),
  ('2026-08-27',  0.00, 'en attente', 8, 2),
  ('2026-09-01', 45.00, 'payé',       9, 1),
  ('2026-09-30',  0.00, 'en attente', 10, 1);

INSERT INTO fourniture (nom, prix) VALUES
  ('Cahier A4 ligné',        1.80),  -- id 1
  ('Crayons de couleur x24', 6.50),  -- id 2
  ('Colle en bâton',         1.20),  -- id 3
  ('Ciseaux à bouts ronds',  2.90),  -- id 4
  ('Pâte à modeler x8',      4.75),  -- id 5
  ('Farde à rabats',         2.10);  -- id 6

INSERT INTO commande (date_commande, montant_total, id_secretaire) VALUES
  ('2026-08-18', 0, 1),  -- id 1
  ('2026-09-21', 0, 2);  -- id 2

INSERT INTO ligne_commande (id_commande, id_produit, quantite, reduction) VALUES
  (1, 1, 50, 10.00),
  (1, 2, 20, NULL),
  (1, 3, 40, 5.00),
  (1, 4, 15, NULL),
  (2, 5, 12, NULL),
  (2, 6, 30, 10.00);

-- Calcul du montant total de chaque commande à partir de ses lignes
-- (remplacé plus tard par la procédure stockée / un trigger)
UPDATE commande c
   SET montant_total = (
       SELECT ROUND(SUM(f.prix * lc.quantite * (1 - COALESCE(lc.reduction, 0) / 100)), 2)
         FROM ligne_commande lc
         JOIN fourniture f ON f.id_produit = lc.id_produit
        WHERE lc.id_commande = c.id_commande
   );