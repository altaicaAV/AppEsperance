-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*
CREATE TYPE "public"."role_utilisateur" AS ENUM('direction', 'secretariat', 'enseignant', 'paramedical', 'tuteur', 'eleve');--> statement-breakpoint
CREATE TYPE "public"."type_enseignement" AS ENUM('type 1', 'type 2', 'type 8');--> statement-breakpoint
CREATE TYPE "public"."type_evaluation" AS ENUM('controle', 'examen', 'devoir', 'projet');--> statement-breakpoint
CREATE TABLE "users" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "users_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"role" "role_utilisateur" NOT NULL,
	"email" varchar(100) NOT NULL,
	"password_hash" varchar(255) NOT NULL,
	"actif" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT "users_email_key" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "session" (
	"id_session" varchar(64) PRIMARY KEY NOT NULL,
	"id_user" integer NOT NULL,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE "direction" (
	"id_direction" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "direction_id_direction_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"telephone" varchar(50) NOT NULL,
	"poste" varchar(50) NOT NULL,
	"id_user" integer,
	CONSTRAINT "direction_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "secretariat" (
	"id_secretaire" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "secretariat_id_secretaire_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"telephone" varchar(50) NOT NULL,
	"poste" varchar(50) NOT NULL,
	"id_user" integer,
	CONSTRAINT "secretariat_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "enseignant" (
	"id_enseignant" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "enseignant_id_enseignant_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"poste" varchar(50) NOT NULL,
	"local_" varchar(50),
	"id_user" integer,
	CONSTRAINT "enseignant_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "personnel_paramedical" (
	"id_paramedical" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "personnel_paramedical_id_paramedical_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"profession" varchar(50) NOT NULL,
	"local_" varchar(50),
	"id_user" integer,
	CONSTRAINT "personnel_paramedical_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "tuteur_legal" (
	"id_tuteur" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "tuteur_legal_id_tuteur_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"telephone" varchar(50) NOT NULL,
	"lien" varchar(50) NOT NULL,
	"id_user" integer,
	CONSTRAINT "tuteur_legal_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "matiere" (
	"id_matiere" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "matiere_id_matiere_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"heures" integer NOT NULL,
	"description_" text
);
--> statement-breakpoint
CREATE TABLE "niveau" (
	"id_niveau" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "niveau_id_niveau_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom_niveau" varchar(50) NOT NULL
);
--> statement-breakpoint
CREATE TABLE "programme" (
	"id_programme" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "programme_id_programme_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom_programme" varchar(50) NOT NULL,
	"annee_scolaire" varchar(20) NOT NULL,
	"description_" text,
	"id_niveau" integer
);
--> statement-breakpoint
CREATE TABLE "classe" (
	"id_classe" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "classe_id_classe_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom_classe" varchar(50) NOT NULL,
	"tranche_age" varchar(20) NOT NULL,
	"capacite" integer NOT NULL,
	"id_programme" integer,
	"id_enseignant" integer,
	CONSTRAINT "classe_capacite_check" CHECK (capacite > 0)
);
--> statement-breakpoint
CREATE TABLE "eleve" (
	"id_eleve" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "eleve_id_eleve_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prenom" varchar(50) NOT NULL,
	"adresse" varchar(100) NOT NULL,
	"mail" varchar(50) NOT NULL,
	"date_naissance" date NOT NULL,
	"type_" "type_enseignement",
	"id_classe" integer,
	"id_tuteur" integer,
	"id_user" integer,
	CONSTRAINT "eleve_id_user_key" UNIQUE("id_user")
);
--> statement-breakpoint
CREATE TABLE "evaluation" (
	"id_evaluation" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "evaluation_id_evaluation_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"coefficient" integer NOT NULL,
	"type_evaluation" "type_evaluation" NOT NULL,
	"date_evaluation" date NOT NULL,
	"id_matiere" integer,
	"id_periode" integer
);
--> statement-breakpoint
CREATE TABLE "periode" (
	"id_periode" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "periode_id_periode_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"date_debut" date NOT NULL,
	"date_fin" date NOT NULL,
	"coefficient" integer NOT NULL,
	CONSTRAINT "periode_check" CHECK (date_fin >= date_debut)
);
--> statement-breakpoint
CREATE TABLE "conseil_de_classe" (
	"id_conseil" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "conseil_de_classe_id_conseil_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"date_conseil" date NOT NULL,
	"id_periode" integer
);
--> statement-breakpoint
CREATE TABLE "intervention" (
	"id_intervention" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "intervention_id_intervention_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"type_intervention" varchar(50) NOT NULL,
	"frequence" varchar(20) NOT NULL,
	"id_paramedical" integer
);
--> statement-breakpoint
CREATE TABLE "activite_extra" (
	"id_activite" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "activite_extra_id_activite_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"lieu" varchar(50) NOT NULL,
	"description_" text,
	"date_activite" date NOT NULL,
	"cout" numeric(10, 2) NOT NULL
);
--> statement-breakpoint
CREATE TABLE "reunion" (
	"id_reunion" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "reunion_id_reunion_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"date_reunion" date NOT NULL,
	"commentaire" text,
	"id_direction" integer
);
--> statement-breakpoint
CREATE TABLE "inscription" (
	"id_inscription" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "inscription_id_inscription_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"date_inscription" date NOT NULL,
	"total_paye" numeric(10, 2) NOT NULL,
	"statut_paiement" varchar(20) NOT NULL,
	"id_eleve" integer,
	"id_secretaire" integer
);
--> statement-breakpoint
CREATE TABLE "commande" (
	"id_commande" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "commande_id_commande_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"date_commande" date NOT NULL,
	"montant_total" numeric(10, 2) DEFAULT '0' NOT NULL,
	"id_secretaire" integer
);
--> statement-breakpoint
CREATE TABLE "fourniture" (
	"id_produit" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "fourniture_id_produit_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nom" varchar(50) NOT NULL,
	"prix" numeric(10, 2) NOT NULL,
	CONSTRAINT "fourniture_prix_check" CHECK (prix >= (0)::numeric)
);
--> statement-breakpoint
CREATE TABLE "programme_matiere" (
	"id_programme" integer NOT NULL,
	"id_matiere" integer NOT NULL,
	"coefficient" integer,
	CONSTRAINT "programme_matiere_pkey" PRIMARY KEY("id_programme","id_matiere")
);
--> statement-breakpoint
CREATE TABLE "absence" (
	"id_eleve" integer NOT NULL,
	"date_" date NOT NULL,
	"statut" varchar(20) NOT NULL,
	CONSTRAINT "absence_pkey" PRIMARY KEY("id_eleve","date_")
);
--> statement-breakpoint
CREATE TABLE "resultat" (
	"id_evaluation" integer NOT NULL,
	"id_eleve" integer NOT NULL,
	"note" numeric(5, 2) NOT NULL,
	"commentaire" text,
	CONSTRAINT "resultat_pkey" PRIMARY KEY("id_evaluation","id_eleve")
);
--> statement-breakpoint
CREATE TABLE "visite" (
	"id_intervention" integer NOT NULL,
	"id_eleve" integer NOT NULL,
	"date_visite" date NOT NULL,
	"etat_visite" varchar(20) NOT NULL,
	CONSTRAINT "visite_pkey" PRIMARY KEY("id_intervention","id_eleve","date_visite")
);
--> statement-breakpoint
CREATE TABLE "prof_acti" (
	"id_enseignant" integer NOT NULL,
	"id_activite" integer NOT NULL,
	"statut" varchar(20) NOT NULL,
	"commentaire" text,
	CONSTRAINT "prof_acti_pkey" PRIMARY KEY("id_enseignant","id_activite")
);
--> statement-breakpoint
CREATE TABLE "presence_activite" (
	"id_eleve" integer NOT NULL,
	"id_activite" integer NOT NULL,
	"statut" varchar(20) NOT NULL,
	"paiement" boolean DEFAULT false NOT NULL,
	CONSTRAINT "presence_activite_pkey" PRIMARY KEY("id_eleve","id_activite")
);
--> statement-breakpoint
CREATE TABLE "presence_reunion" (
	"id_enseignant" integer NOT NULL,
	"id_reunion" integer NOT NULL,
	"statut" varchar(20) NOT NULL,
	"commentaire" text,
	CONSTRAINT "presence_reunion_pkey" PRIMARY KEY("id_enseignant","id_reunion")
);
--> statement-breakpoint
CREATE TABLE "ligne_commande" (
	"id_commande" integer NOT NULL,
	"id_produit" integer NOT NULL,
	"quantite" integer NOT NULL,
	"reduction" numeric(5, 2),
	CONSTRAINT "ligne_commande_pkey" PRIMARY KEY("id_commande","id_produit"),
	CONSTRAINT "ligne_commande_quantite_check" CHECK (quantite > 0)
);
--> statement-breakpoint
CREATE TABLE "conseil_eleve" (
	"id_conseil" integer NOT NULL,
	"id_eleve" integer NOT NULL,
	"ressources" text,
	"difficultes" text,
	"objectifs" text,
	CONSTRAINT "conseil_eleve_pkey" PRIMARY KEY("id_conseil","id_eleve")
);
--> statement-breakpoint
ALTER TABLE "session" ADD CONSTRAINT "session_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "direction" ADD CONSTRAINT "direction_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "secretariat" ADD CONSTRAINT "secretariat_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "enseignant" ADD CONSTRAINT "enseignant_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "personnel_paramedical" ADD CONSTRAINT "personnel_paramedical_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tuteur_legal" ADD CONSTRAINT "tuteur_legal_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "programme" ADD CONSTRAINT "programme_id_niveau_fkey" FOREIGN KEY ("id_niveau") REFERENCES "public"."niveau"("id_niveau") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "classe" ADD CONSTRAINT "classe_id_programme_fkey" FOREIGN KEY ("id_programme") REFERENCES "public"."programme"("id_programme") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "classe" ADD CONSTRAINT "classe_id_enseignant_fkey" FOREIGN KEY ("id_enseignant") REFERENCES "public"."enseignant"("id_enseignant") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "eleve" ADD CONSTRAINT "eleve_id_classe_fkey" FOREIGN KEY ("id_classe") REFERENCES "public"."classe"("id_classe") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "eleve" ADD CONSTRAINT "eleve_id_tuteur_fkey" FOREIGN KEY ("id_tuteur") REFERENCES "public"."tuteur_legal"("id_tuteur") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "eleve" ADD CONSTRAINT "eleve_id_user_fkey" FOREIGN KEY ("id_user") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "evaluation" ADD CONSTRAINT "evaluation_id_matiere_fkey" FOREIGN KEY ("id_matiere") REFERENCES "public"."matiere"("id_matiere") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "evaluation" ADD CONSTRAINT "evaluation_id_periode_fkey" FOREIGN KEY ("id_periode") REFERENCES "public"."periode"("id_periode") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "conseil_de_classe" ADD CONSTRAINT "conseil_de_classe_id_periode_fkey" FOREIGN KEY ("id_periode") REFERENCES "public"."periode"("id_periode") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "intervention" ADD CONSTRAINT "intervention_id_paramedical_fkey" FOREIGN KEY ("id_paramedical") REFERENCES "public"."personnel_paramedical"("id_paramedical") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reunion" ADD CONSTRAINT "reunion_id_direction_fkey" FOREIGN KEY ("id_direction") REFERENCES "public"."direction"("id_direction") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inscription" ADD CONSTRAINT "inscription_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "inscription" ADD CONSTRAINT "inscription_id_secretaire_fkey" FOREIGN KEY ("id_secretaire") REFERENCES "public"."secretariat"("id_secretaire") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "commande" ADD CONSTRAINT "commande_id_secretaire_fkey" FOREIGN KEY ("id_secretaire") REFERENCES "public"."secretariat"("id_secretaire") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "programme_matiere" ADD CONSTRAINT "programme_matiere_id_programme_fkey" FOREIGN KEY ("id_programme") REFERENCES "public"."programme"("id_programme") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "programme_matiere" ADD CONSTRAINT "programme_matiere_id_matiere_fkey" FOREIGN KEY ("id_matiere") REFERENCES "public"."matiere"("id_matiere") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "absence" ADD CONSTRAINT "absence_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "resultat" ADD CONSTRAINT "resultat_id_evaluation_fkey" FOREIGN KEY ("id_evaluation") REFERENCES "public"."evaluation"("id_evaluation") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "resultat" ADD CONSTRAINT "resultat_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "visite" ADD CONSTRAINT "visite_id_intervention_fkey" FOREIGN KEY ("id_intervention") REFERENCES "public"."intervention"("id_intervention") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "visite" ADD CONSTRAINT "visite_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "prof_acti" ADD CONSTRAINT "prof_acti_id_enseignant_fkey" FOREIGN KEY ("id_enseignant") REFERENCES "public"."enseignant"("id_enseignant") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "prof_acti" ADD CONSTRAINT "prof_acti_id_activite_fkey" FOREIGN KEY ("id_activite") REFERENCES "public"."activite_extra"("id_activite") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "presence_activite" ADD CONSTRAINT "presence_activite_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "presence_activite" ADD CONSTRAINT "presence_activite_id_activite_fkey" FOREIGN KEY ("id_activite") REFERENCES "public"."activite_extra"("id_activite") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "presence_reunion" ADD CONSTRAINT "presence_reunion_id_enseignant_fkey" FOREIGN KEY ("id_enseignant") REFERENCES "public"."enseignant"("id_enseignant") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "presence_reunion" ADD CONSTRAINT "presence_reunion_id_reunion_fkey" FOREIGN KEY ("id_reunion") REFERENCES "public"."reunion"("id_reunion") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ligne_commande" ADD CONSTRAINT "ligne_commande_id_commande_fkey" FOREIGN KEY ("id_commande") REFERENCES "public"."commande"("id_commande") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "ligne_commande" ADD CONSTRAINT "ligne_commande_id_produit_fkey" FOREIGN KEY ("id_produit") REFERENCES "public"."fourniture"("id_produit") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "conseil_eleve" ADD CONSTRAINT "conseil_eleve_id_conseil_fkey" FOREIGN KEY ("id_conseil") REFERENCES "public"."conseil_de_classe"("id_conseil") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "conseil_eleve" ADD CONSTRAINT "conseil_eleve_id_eleve_fkey" FOREIGN KEY ("id_eleve") REFERENCES "public"."eleve"("id_eleve") ON DELETE no action ON UPDATE no action;
*/