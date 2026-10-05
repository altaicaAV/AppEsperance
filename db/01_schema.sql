-- ---------------------------------------------------------------------
-- 0. Types ENUM
-- ---------------------------------------------------------------------
CREATE TYPE role_utilisateur AS ENUM ('direction', 'secretariat', 'enseignant', 'paramedical', 'tuteur', 'eleve');

CREATE TYPE type_enseignement AS ENUM ('type 1', 'type 2', 'type 8');

CREATE TYPE type_evaluation AS ENUM ('controle', 'examen', 'devoir', 'projet');


-- ---------------------------------------------------------------------
-- 1. Comptes de connexion
-- ---------------------------------------------------------------------
CREATE TABLE users (
    id            INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role          role_utilisateur NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    actif         BOOLEAN   NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ---------------------------------------------------------------------
-- 2. Acteurs (chacun peut être lié à un compte users)
-- ---------------------------------------------------------------------
CREATE TABLE direction (
    id_direction   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    telephone      VARCHAR(50)  NOT NULL,
    poste          VARCHAR(50)  NOT NULL,
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE secretariat (
    id_secretaire  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    telephone      VARCHAR(50)  NOT NULL,
    poste          VARCHAR(50)  NOT NULL,
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE enseignant (
    id_enseignant  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    poste          VARCHAR(50)  NOT NULL,
    local_         VARCHAR(50),
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE personnel_paramedical (
    id_paramedical INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    profession     VARCHAR(50)  NOT NULL,
    local_         VARCHAR(50),
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE tuteur_legal (
    id_tuteur      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    telephone      VARCHAR(50)  NOT NULL,
    lien           VARCHAR(50)  NOT NULL,
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);


-- ---------------------------------------------------------------------
-- 3. Enseignement et structure pédagogique
-- ---------------------------------------------------------------------
CREATE TABLE niveau (
    id_niveau  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_niveau VARCHAR(50) NOT NULL
);

CREATE TABLE matiere (
    id_matiere   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom          VARCHAR(50) NOT NULL,
    heures       INT         NOT NULL,
    description_ TEXT
);

CREATE TABLE programme (
    id_programme   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_programme  VARCHAR(50) NOT NULL,
    annee_scolaire VARCHAR(20) NOT NULL,
    description_   TEXT,
    id_niveau      INT REFERENCES niveau(id_niveau)
);

CREATE TABLE programme_matiere (
    id_programme INT NOT NULL REFERENCES programme(id_programme),
    id_matiere   INT NOT NULL REFERENCES matiere(id_matiere),
    coefficient  INT,
    PRIMARY KEY (id_programme, id_matiere)
);

CREATE TABLE classe (
    id_classe     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_classe    VARCHAR(50) NOT NULL,
    tranche_age   VARCHAR(20) NOT NULL,
    capacite      INT         NOT NULL CHECK (capacite > 0),
    id_programme  INT REFERENCES programme(id_programme),
    id_enseignant INT REFERENCES enseignant(id_enseignant)
);

CREATE TABLE eleve (
    id_eleve       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom            VARCHAR(50)  NOT NULL,
    prenom         VARCHAR(50)  NOT NULL,
    adresse        VARCHAR(100) NOT NULL,
    mail           VARCHAR(50)  NOT NULL,
    date_naissance DATE         NOT NULL,
    type_          type_enseignement,                       -- NULL = pas de type
    id_classe      INT REFERENCES classe(id_classe),        -- NULL = pas encore affecté
    id_tuteur      INT REFERENCES tuteur_legal(id_tuteur),
    id_user        INT UNIQUE REFERENCES users(id) ON DELETE SET NULL
);


-- ---------------------------------------------------------------------
-- 4. Évaluations et suivi pédagogique
-- ---------------------------------------------------------------------
CREATE TABLE periode (
    id_periode  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom         VARCHAR(50) NOT NULL,
    date_debut  DATE        NOT NULL,
    date_fin    DATE        NOT NULL,
    coefficient INT         NOT NULL,
    CHECK (date_fin >= date_debut)
);

CREATE TABLE evaluation (
    id_evaluation   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    coefficient     INT         NOT NULL,
    type_evaluation type_evaluation NOT NULL,
    date_evaluation DATE        NOT NULL,
    id_matiere      INT REFERENCES matiere(id_matiere),
    id_periode      INT REFERENCES periode(id_periode)
);

CREATE TABLE resultat (
    id_evaluation INT NOT NULL REFERENCES evaluation(id_evaluation),
    id_eleve      INT NOT NULL REFERENCES eleve(id_eleve),
    note          DECIMAL(5,2) NOT NULL,
    commentaire   TEXT,
    PRIMARY KEY (id_evaluation, id_eleve)
);

CREATE TABLE conseil_de_classe (
    id_conseil   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_conseil DATE NOT NULL,
    id_periode   INT REFERENCES periode(id_periode)
);

CREATE TABLE conseil_eleve (
    id_conseil  INT NOT NULL REFERENCES conseil_de_classe(id_conseil),
    id_eleve    INT NOT NULL REFERENCES eleve(id_eleve),
    ressources  TEXT,
    difficultes TEXT,
    objectifs   TEXT,
    PRIMARY KEY (id_conseil, id_eleve)
);


-- ---------------------------------------------------------------------
-- 5. Suivi paramédical
-- ---------------------------------------------------------------------
CREATE TABLE intervention (
    id_intervention   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_intervention VARCHAR(50) NOT NULL,
    frequence         VARCHAR(20) NOT NULL,
    id_paramedical    INT REFERENCES personnel_paramedical(id_paramedical)
);

CREATE TABLE visite (
    id_intervention INT  NOT NULL REFERENCES intervention(id_intervention),
    id_eleve        INT  NOT NULL REFERENCES eleve(id_eleve),
    date_visite     DATE NOT NULL,
    etat_visite     VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_intervention, id_eleve, date_visite)
);


-- ---------------------------------------------------------------------
-- 6. Vie scolaire et activités
-- ---------------------------------------------------------------------
CREATE TABLE absence (
    id_eleve INT  NOT NULL REFERENCES eleve(id_eleve),
    date_    DATE NOT NULL,
    statut   VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_eleve, date_)
);

CREATE TABLE activite_extra (
    id_activite   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom           VARCHAR(50)   NOT NULL,
    lieu          VARCHAR(50)   NOT NULL,
    description_  TEXT,
    date_activite DATE          NOT NULL,
    cout          DECIMAL(10,2) NOT NULL
);

CREATE TABLE prof_acti (
    id_enseignant INT NOT NULL REFERENCES enseignant(id_enseignant),
    id_activite   INT NOT NULL REFERENCES activite_extra(id_activite),
    statut        VARCHAR(20) NOT NULL,
    commentaire   TEXT,
    PRIMARY KEY (id_enseignant, id_activite)
);

CREATE TABLE presence_activite (
    id_eleve    INT NOT NULL REFERENCES eleve(id_eleve),
    id_activite INT NOT NULL REFERENCES activite_extra(id_activite),
    statut      VARCHAR(20) NOT NULL,
    paiement    BOOLEAN     NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id_eleve, id_activite)
);

CREATE TABLE reunion (
    id_reunion   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_reunion DATE NOT NULL,
    commentaire  TEXT,
    id_direction INT REFERENCES direction(id_direction)
);

CREATE TABLE presence_reunion (
    id_enseignant INT NOT NULL REFERENCES enseignant(id_enseignant),
    id_reunion    INT NOT NULL REFERENCES reunion(id_reunion),
    statut        VARCHAR(20) NOT NULL,
    commentaire   TEXT,
    PRIMARY KEY (id_enseignant, id_reunion)
);


-- ---------------------------------------------------------------------
-- 7. Administration et fournitures
-- ---------------------------------------------------------------------
CREATE TABLE inscription (
    id_inscription   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_inscription DATE          NOT NULL,
    total_paye       DECIMAL(10,2) NOT NULL,
    statut_paiement  VARCHAR(20)   NOT NULL,
    id_eleve         INT REFERENCES eleve(id_eleve),
    id_secretaire    INT REFERENCES secretariat(id_secretaire)
);

CREATE TABLE fourniture (
    id_produit INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom        VARCHAR(50)   NOT NULL,
    prix       DECIMAL(10,2) NOT NULL CHECK (prix >= 0)
);

CREATE TABLE commande (
    id_commande   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_commande DATE          NOT NULL,
    montant_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    id_secretaire INT REFERENCES secretariat(id_secretaire)
);

CREATE TABLE ligne_commande (
    id_commande INT NOT NULL REFERENCES commande(id_commande),
    id_produit  INT NOT NULL REFERENCES fourniture(id_produit),
    quantite    INT NOT NULL CHECK (quantite > 0),
    reduction   DECIMAL(5,2),
    PRIMARY KEY (id_commande, id_produit)
);