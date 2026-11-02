import { pgTable, unique, integer, varchar, boolean, timestamp, foreignKey, serial, date, text, check, numeric, primaryKey, pgEnum } from "drizzle-orm/pg-core"
import { sql } from "drizzle-orm"

export const roleUtilisateur = pgEnum("role_utilisateur", ['direction', 'secretariat', 'enseignant', 'paramedical', 'tuteur', 'eleve'])
export const typeEnseignement = pgEnum("type_enseignement", ['type 1', 'type 2', 'type 8'])
export const typeEvaluation = pgEnum("type_evaluation", ['controle', 'examen', 'devoir', 'projet'])


export const users = pgTable("users", {
	id: integer().primaryKey().generatedAlwaysAsIdentity({ name: "users_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	role: roleUtilisateur().notNull(),
	email: varchar({ length: 100 }).notNull(),
	passwordHash: varchar("password_hash", { length: 255 }).notNull(),
	actif: boolean().default(true).notNull(),
	createdAt: timestamp("created_at", { mode: 'date' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
	totpSecret: varchar("totp_secret", { length: 32 }),
	totpActive: boolean("totp_active").default(false).notNull(),
}, (table) => [
	unique("users_email_key").on(table.email),
]);

export const session = pgTable("session", {
	idSession: varchar("id_session", { length: 64 }).primaryKey().notNull(),
	idUser: integer("id_user").notNull(),
	expiresAt: timestamp("expires_at", { mode: 'date' }).notNull(),
	createdAt: timestamp("created_at", { mode: 'date' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "session_id_user_fkey"
		}).onDelete("cascade"),
]);

export const tokenReset = pgTable("token_reset", {
	id: serial().primaryKey().notNull(),
	idUser: integer("id_user").notNull(),
	tokenHash: varchar("token_hash", { length: 64 }).notNull(),
	expiresAt: timestamp("expires_at", { mode: 'date' }).notNull(),
	usedAt: timestamp("used_at", { mode: 'date' }),
	createdAt: timestamp("created_at", { mode: 'date' }).default(sql`CURRENT_TIMESTAMP`).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "token_reset_id_user_fkey"
		}).onDelete("cascade"),
	unique("token_reset_token_hash_key").on(table.tokenHash),
]);

export const direction = pgTable("direction", {
	idDirection: integer("id_direction").primaryKey().generatedAlwaysAsIdentity({ name: "direction_id_direction_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	telephone: varchar({ length: 50 }).notNull(),
	poste: varchar({ length: 50 }).notNull(),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "direction_id_user_fkey"
		}).onDelete("set null"),
	unique("direction_id_user_key").on(table.idUser),
]);

export const secretariat = pgTable("secretariat", {
	idSecretaire: integer("id_secretaire").primaryKey().generatedAlwaysAsIdentity({ name: "secretariat_id_secretaire_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	telephone: varchar({ length: 50 }).notNull(),
	poste: varchar({ length: 50 }).notNull(),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "secretariat_id_user_fkey"
		}).onDelete("set null"),
	unique("secretariat_id_user_key").on(table.idUser),
]);

export const enseignant = pgTable("enseignant", {
	idEnseignant: integer("id_enseignant").primaryKey().generatedAlwaysAsIdentity({ name: "enseignant_id_enseignant_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	poste: varchar({ length: 50 }).notNull(),
	local: varchar("local_", { length: 50 }),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "enseignant_id_user_fkey"
		}).onDelete("set null"),
	unique("enseignant_id_user_key").on(table.idUser),
]);

export const personnelParamedical = pgTable("personnel_paramedical", {
	idParamedical: integer("id_paramedical").primaryKey().generatedAlwaysAsIdentity({ name: "personnel_paramedical_id_paramedical_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	profession: varchar({ length: 50 }).notNull(),
	local: varchar("local_", { length: 50 }),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "personnel_paramedical_id_user_fkey"
		}).onDelete("set null"),
	unique("personnel_paramedical_id_user_key").on(table.idUser),
]);

export const tuteurLegal = pgTable("tuteur_legal", {
	idTuteur: integer("id_tuteur").primaryKey().generatedAlwaysAsIdentity({ name: "tuteur_legal_id_tuteur_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	telephone: varchar({ length: 50 }).notNull(),
	lien: varchar({ length: 50 }).notNull(),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "tuteur_legal_id_user_fkey"
		}).onDelete("set null"),
	unique("tuteur_legal_id_user_key").on(table.idUser),
]);

export const matiere = pgTable("matiere", {
	idMatiere: integer("id_matiere").primaryKey().generatedAlwaysAsIdentity({ name: "matiere_id_matiere_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	heures: integer().notNull(),
	description: text("description_"),
});

export const niveau = pgTable("niveau", {
	idNiveau: integer("id_niveau").primaryKey().generatedAlwaysAsIdentity({ name: "niveau_id_niveau_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nomNiveau: varchar("nom_niveau", { length: 50 }).notNull(),
});

export const programme = pgTable("programme", {
	idProgramme: integer("id_programme").primaryKey().generatedAlwaysAsIdentity({ name: "programme_id_programme_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nomProgramme: varchar("nom_programme", { length: 50 }).notNull(),
	anneeScolaire: varchar("annee_scolaire", { length: 20 }).notNull(),
	description: text("description_"),
	idNiveau: integer("id_niveau"),
}, (table) => [
	foreignKey({
			columns: [table.idNiveau],
			foreignColumns: [niveau.idNiveau],
			name: "programme_id_niveau_fkey"
		}),
]);

export const classe = pgTable("classe", {
	idClasse: integer("id_classe").primaryKey().generatedAlwaysAsIdentity({ name: "classe_id_classe_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nomClasse: varchar("nom_classe", { length: 50 }).notNull(),
	trancheAge: varchar("tranche_age", { length: 20 }).notNull(),
	capacite: integer().notNull(),
	idProgramme: integer("id_programme"),
	idEnseignant: integer("id_enseignant"),
}, (table) => [
	foreignKey({
			columns: [table.idProgramme],
			foreignColumns: [programme.idProgramme],
			name: "classe_id_programme_fkey"
		}),
	foreignKey({
			columns: [table.idEnseignant],
			foreignColumns: [enseignant.idEnseignant],
			name: "classe_id_enseignant_fkey"
		}),
	check("classe_capacite_check", sql`capacite > 0`),
]);

export const eleve = pgTable("eleve", {
	idEleve: integer("id_eleve").primaryKey().generatedAlwaysAsIdentity({ name: "eleve_id_eleve_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prenom: varchar({ length: 50 }).notNull(),
	adresse: varchar({ length: 100 }).notNull(),
	mail: varchar({ length: 50 }).notNull(),
	dateNaissance: date("date_naissance").notNull(),
	type: typeEnseignement("type_"),
	idClasse: integer("id_classe"),
	idTuteur: integer("id_tuteur"),
	idUser: integer("id_user"),
}, (table) => [
	foreignKey({
			columns: [table.idClasse],
			foreignColumns: [classe.idClasse],
			name: "eleve_id_classe_fkey"
		}),
	foreignKey({
			columns: [table.idTuteur],
			foreignColumns: [tuteurLegal.idTuteur],
			name: "eleve_id_tuteur_fkey"
		}),
	foreignKey({
			columns: [table.idUser],
			foreignColumns: [users.id],
			name: "eleve_id_user_fkey"
		}).onDelete("set null"),
	unique("eleve_id_user_key").on(table.idUser),
]);

export const evaluation = pgTable("evaluation", {
	idEvaluation: integer("id_evaluation").primaryKey().generatedAlwaysAsIdentity({ name: "evaluation_id_evaluation_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	coefficient: integer().notNull(),
	typeEvaluation: typeEvaluation("type_evaluation").notNull(),
	dateEvaluation: date("date_evaluation").notNull(),
	idMatiere: integer("id_matiere"),
	idPeriode: integer("id_periode"),
}, (table) => [
	foreignKey({
			columns: [table.idMatiere],
			foreignColumns: [matiere.idMatiere],
			name: "evaluation_id_matiere_fkey"
		}),
	foreignKey({
			columns: [table.idPeriode],
			foreignColumns: [periode.idPeriode],
			name: "evaluation_id_periode_fkey"
		}),
]);

export const periode = pgTable("periode", {
	idPeriode: integer("id_periode").primaryKey().generatedAlwaysAsIdentity({ name: "periode_id_periode_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	dateDebut: date("date_debut").notNull(),
	dateFin: date("date_fin").notNull(),
	coefficient: integer().notNull(),
}, (table) => [
	check("periode_check", sql`date_fin >= date_debut`),
]);

export const conseilDeClasse = pgTable("conseil_de_classe", {
	idConseil: integer("id_conseil").primaryKey().generatedAlwaysAsIdentity({ name: "conseil_de_classe_id_conseil_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	dateConseil: date("date_conseil").notNull(),
	idPeriode: integer("id_periode"),
}, (table) => [
	foreignKey({
			columns: [table.idPeriode],
			foreignColumns: [periode.idPeriode],
			name: "conseil_de_classe_id_periode_fkey"
		}),
]);

export const intervention = pgTable("intervention", {
	idIntervention: integer("id_intervention").primaryKey().generatedAlwaysAsIdentity({ name: "intervention_id_intervention_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	typeIntervention: varchar("type_intervention", { length: 50 }).notNull(),
	frequence: varchar({ length: 20 }).notNull(),
	idParamedical: integer("id_paramedical"),
}, (table) => [
	foreignKey({
			columns: [table.idParamedical],
			foreignColumns: [personnelParamedical.idParamedical],
			name: "intervention_id_paramedical_fkey"
		}),
]);

export const activiteExtra = pgTable("activite_extra", {
	idActivite: integer("id_activite").primaryKey().generatedAlwaysAsIdentity({ name: "activite_extra_id_activite_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	lieu: varchar({ length: 50 }).notNull(),
	description: text("description_"),
	dateActivite: date("date_activite").notNull(),
	cout: numeric({ precision: 10, scale:  2 }).notNull(),
});

export const reunion = pgTable("reunion", {
	idReunion: integer("id_reunion").primaryKey().generatedAlwaysAsIdentity({ name: "reunion_id_reunion_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	dateReunion: date("date_reunion").notNull(),
	commentaire: text(),
	idDirection: integer("id_direction"),
}, (table) => [
	foreignKey({
			columns: [table.idDirection],
			foreignColumns: [direction.idDirection],
			name: "reunion_id_direction_fkey"
		}),
]);

export const inscription = pgTable("inscription", {
	idInscription: integer("id_inscription").primaryKey().generatedAlwaysAsIdentity({ name: "inscription_id_inscription_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	dateInscription: date("date_inscription").notNull(),
	totalPaye: numeric("total_paye", { precision: 10, scale:  2 }).notNull(),
	statutPaiement: varchar("statut_paiement", { length: 20 }).notNull(),
	idEleve: integer("id_eleve"),
	idSecretaire: integer("id_secretaire"),
}, (table) => [
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "inscription_id_eleve_fkey"
		}),
	foreignKey({
			columns: [table.idSecretaire],
			foreignColumns: [secretariat.idSecretaire],
			name: "inscription_id_secretaire_fkey"
		}),
]);

export const commande = pgTable("commande", {
	idCommande: integer("id_commande").primaryKey().generatedAlwaysAsIdentity({ name: "commande_id_commande_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	dateCommande: date("date_commande").notNull(),
	montantTotal: numeric("montant_total", { precision: 10, scale:  2 }).default('0').notNull(),
	idSecretaire: integer("id_secretaire"),
}, (table) => [
	foreignKey({
			columns: [table.idSecretaire],
			foreignColumns: [secretariat.idSecretaire],
			name: "commande_id_secretaire_fkey"
		}),
]);

export const fourniture = pgTable("fourniture", {
	idProduit: integer("id_produit").primaryKey().generatedAlwaysAsIdentity({ name: "fourniture_id_produit_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	nom: varchar({ length: 50 }).notNull(),
	prix: numeric({ precision: 10, scale:  2 }).notNull(),
}, (table) => [
	check("fourniture_prix_check", sql`prix >= (0)::numeric`),
]);

export const programmeMatiere = pgTable("programme_matiere", {
	idProgramme: integer("id_programme").notNull(),
	idMatiere: integer("id_matiere").notNull(),
	coefficient: integer(),
}, (table) => [
	foreignKey({
			columns: [table.idProgramme],
			foreignColumns: [programme.idProgramme],
			name: "programme_matiere_id_programme_fkey"
		}),
	foreignKey({
			columns: [table.idMatiere],
			foreignColumns: [matiere.idMatiere],
			name: "programme_matiere_id_matiere_fkey"
		}),
	primaryKey({ columns: [table.idProgramme, table.idMatiere], name: "programme_matiere_pkey"}),
]);

export const absence = pgTable("absence", {
	idEleve: integer("id_eleve").notNull(),
	date: date("date_").notNull(),
	statut: varchar({ length: 20 }).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "absence_id_eleve_fkey"
		}),
	primaryKey({ columns: [table.idEleve, table.date], name: "absence_pkey"}),
]);

export const resultat = pgTable("resultat", {
	idEvaluation: integer("id_evaluation").notNull(),
	idEleve: integer("id_eleve").notNull(),
	note: numeric({ precision: 5, scale:  2 }).notNull(),
	commentaire: text(),
}, (table) => [
	foreignKey({
			columns: [table.idEvaluation],
			foreignColumns: [evaluation.idEvaluation],
			name: "resultat_id_evaluation_fkey"
		}),
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "resultat_id_eleve_fkey"
		}),
	primaryKey({ columns: [table.idEvaluation, table.idEleve], name: "resultat_pkey"}),
]);

export const visite = pgTable("visite", {
	idIntervention: integer("id_intervention").notNull(),
	idEleve: integer("id_eleve").notNull(),
	dateVisite: date("date_visite").notNull(),
	etatVisite: varchar("etat_visite", { length: 20 }).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.idIntervention],
			foreignColumns: [intervention.idIntervention],
			name: "visite_id_intervention_fkey"
		}),
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "visite_id_eleve_fkey"
		}),
	primaryKey({ columns: [table.idIntervention, table.idEleve, table.dateVisite], name: "visite_pkey"}),
]);

export const presenceActivite = pgTable("presence_activite", {
	idEleve: integer("id_eleve").notNull(),
	idActivite: integer("id_activite").notNull(),
	statut: varchar({ length: 20 }).notNull(),
	paiement: boolean().default(false).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "presence_activite_id_eleve_fkey"
		}),
	foreignKey({
			columns: [table.idActivite],
			foreignColumns: [activiteExtra.idActivite],
			name: "presence_activite_id_activite_fkey"
		}),
	primaryKey({ columns: [table.idEleve, table.idActivite], name: "presence_activite_pkey"}),
]);

export const profActi = pgTable("prof_acti", {
	idEnseignant: integer("id_enseignant").notNull(),
	idActivite: integer("id_activite").notNull(),
	statut: varchar({ length: 20 }).notNull(),
	commentaire: text(),
}, (table) => [
	foreignKey({
			columns: [table.idEnseignant],
			foreignColumns: [enseignant.idEnseignant],
			name: "prof_acti_id_enseignant_fkey"
		}),
	foreignKey({
			columns: [table.idActivite],
			foreignColumns: [activiteExtra.idActivite],
			name: "prof_acti_id_activite_fkey"
		}),
	primaryKey({ columns: [table.idEnseignant, table.idActivite], name: "prof_acti_pkey"}),
]);

export const presenceReunion = pgTable("presence_reunion", {
	idEnseignant: integer("id_enseignant").notNull(),
	idReunion: integer("id_reunion").notNull(),
	statut: varchar({ length: 20 }).notNull(),
	commentaire: text(),
}, (table) => [
	foreignKey({
			columns: [table.idEnseignant],
			foreignColumns: [enseignant.idEnseignant],
			name: "presence_reunion_id_enseignant_fkey"
		}),
	foreignKey({
			columns: [table.idReunion],
			foreignColumns: [reunion.idReunion],
			name: "presence_reunion_id_reunion_fkey"
		}),
	primaryKey({ columns: [table.idEnseignant, table.idReunion], name: "presence_reunion_pkey"}),
]);

export const ligneCommande = pgTable("ligne_commande", {
	idCommande: integer("id_commande").notNull(),
	idProduit: integer("id_produit").notNull(),
	quantite: integer().notNull(),
	reduction: numeric({ precision: 5, scale:  2 }),
}, (table) => [
	foreignKey({
			columns: [table.idCommande],
			foreignColumns: [commande.idCommande],
			name: "ligne_commande_id_commande_fkey"
		}),
	foreignKey({
			columns: [table.idProduit],
			foreignColumns: [fourniture.idProduit],
			name: "ligne_commande_id_produit_fkey"
		}),
	primaryKey({ columns: [table.idCommande, table.idProduit], name: "ligne_commande_pkey"}),
	check("ligne_commande_quantite_check", sql`quantite > 0`),
]);

export const conseilEleve = pgTable("conseil_eleve", {
	idConseil: integer("id_conseil").notNull(),
	idEleve: integer("id_eleve").notNull(),
	ressources: text(),
	difficultes: text(),
	objectifs: text(),
}, (table) => [
	foreignKey({
			columns: [table.idConseil],
			foreignColumns: [conseilDeClasse.idConseil],
			name: "conseil_eleve_id_conseil_fkey"
		}),
	foreignKey({
			columns: [table.idEleve],
			foreignColumns: [eleve.idEleve],
			name: "conseil_eleve_id_eleve_fkey"
		}),
	primaryKey({ columns: [table.idConseil, table.idEleve], name: "conseil_eleve_pkey"}),
]);
