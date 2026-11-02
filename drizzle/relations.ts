import { relations } from "drizzle-orm/relations";
import { users, session, tokenReset, direction, secretariat, enseignant, personnelParamedical, tuteurLegal, niveau, programme, classe, eleve, matiere, evaluation, periode, conseilDeClasse, intervention, reunion, inscription, commande, programmeMatiere, absence, resultat, visite, presenceActivite, activiteExtra, profActi, presenceReunion, ligneCommande, fourniture, conseilEleve } from "./schema";

export const sessionRelations = relations(session, ({one}) => ({
	user: one(users, {
		fields: [session.idUser],
		references: [users.id]
	}),
}));

export const usersRelations = relations(users, ({many}) => ({
	sessions: many(session),
	tokenResets: many(tokenReset),
	directions: many(direction),
	secretariats: many(secretariat),
	enseignants: many(enseignant),
	personnelParamedicals: many(personnelParamedical),
	tuteurLegals: many(tuteurLegal),
	eleves: many(eleve),
}));

export const tokenResetRelations = relations(tokenReset, ({one}) => ({
	user: one(users, {
		fields: [tokenReset.idUser],
		references: [users.id]
	}),
}));

export const directionRelations = relations(direction, ({one, many}) => ({
	user: one(users, {
		fields: [direction.idUser],
		references: [users.id]
	}),
	reunions: many(reunion),
}));

export const secretariatRelations = relations(secretariat, ({one, many}) => ({
	user: one(users, {
		fields: [secretariat.idUser],
		references: [users.id]
	}),
	inscriptions: many(inscription),
	commandes: many(commande),
}));

export const enseignantRelations = relations(enseignant, ({one, many}) => ({
	user: one(users, {
		fields: [enseignant.idUser],
		references: [users.id]
	}),
	classes: many(classe),
	profActis: many(profActi),
	presenceReunions: many(presenceReunion),
}));

export const personnelParamedicalRelations = relations(personnelParamedical, ({one, many}) => ({
	user: one(users, {
		fields: [personnelParamedical.idUser],
		references: [users.id]
	}),
	interventions: many(intervention),
}));

export const tuteurLegalRelations = relations(tuteurLegal, ({one, many}) => ({
	user: one(users, {
		fields: [tuteurLegal.idUser],
		references: [users.id]
	}),
	eleves: many(eleve),
}));

export const programmeRelations = relations(programme, ({one, many}) => ({
	niveau: one(niveau, {
		fields: [programme.idNiveau],
		references: [niveau.idNiveau]
	}),
	classes: many(classe),
	programmeMatieres: many(programmeMatiere),
}));

export const niveauRelations = relations(niveau, ({many}) => ({
	programmes: many(programme),
}));

export const classeRelations = relations(classe, ({one, many}) => ({
	programme: one(programme, {
		fields: [classe.idProgramme],
		references: [programme.idProgramme]
	}),
	enseignant: one(enseignant, {
		fields: [classe.idEnseignant],
		references: [enseignant.idEnseignant]
	}),
	eleves: many(eleve),
}));

export const eleveRelations = relations(eleve, ({one, many}) => ({
	classe: one(classe, {
		fields: [eleve.idClasse],
		references: [classe.idClasse]
	}),
	tuteurLegal: one(tuteurLegal, {
		fields: [eleve.idTuteur],
		references: [tuteurLegal.idTuteur]
	}),
	user: one(users, {
		fields: [eleve.idUser],
		references: [users.id]
	}),
	inscriptions: many(inscription),
	absences: many(absence),
	resultats: many(resultat),
	visites: many(visite),
	presenceActivites: many(presenceActivite),
	conseilEleves: many(conseilEleve),
}));

export const evaluationRelations = relations(evaluation, ({one, many}) => ({
	matiere: one(matiere, {
		fields: [evaluation.idMatiere],
		references: [matiere.idMatiere]
	}),
	periode: one(periode, {
		fields: [evaluation.idPeriode],
		references: [periode.idPeriode]
	}),
	resultats: many(resultat),
}));

export const matiereRelations = relations(matiere, ({many}) => ({
	evaluations: many(evaluation),
	programmeMatieres: many(programmeMatiere),
}));

export const periodeRelations = relations(periode, ({many}) => ({
	evaluations: many(evaluation),
	conseilDeClasses: many(conseilDeClasse),
}));

export const conseilDeClasseRelations = relations(conseilDeClasse, ({one, many}) => ({
	periode: one(periode, {
		fields: [conseilDeClasse.idPeriode],
		references: [periode.idPeriode]
	}),
	conseilEleves: many(conseilEleve),
}));

export const interventionRelations = relations(intervention, ({one, many}) => ({
	personnelParamedical: one(personnelParamedical, {
		fields: [intervention.idParamedical],
		references: [personnelParamedical.idParamedical]
	}),
	visites: many(visite),
}));

export const reunionRelations = relations(reunion, ({one, many}) => ({
	direction: one(direction, {
		fields: [reunion.idDirection],
		references: [direction.idDirection]
	}),
	presenceReunions: many(presenceReunion),
}));

export const inscriptionRelations = relations(inscription, ({one}) => ({
	eleve: one(eleve, {
		fields: [inscription.idEleve],
		references: [eleve.idEleve]
	}),
	secretariat: one(secretariat, {
		fields: [inscription.idSecretaire],
		references: [secretariat.idSecretaire]
	}),
}));

export const commandeRelations = relations(commande, ({one, many}) => ({
	secretariat: one(secretariat, {
		fields: [commande.idSecretaire],
		references: [secretariat.idSecretaire]
	}),
	ligneCommandes: many(ligneCommande),
}));

export const programmeMatiereRelations = relations(programmeMatiere, ({one}) => ({
	programme: one(programme, {
		fields: [programmeMatiere.idProgramme],
		references: [programme.idProgramme]
	}),
	matiere: one(matiere, {
		fields: [programmeMatiere.idMatiere],
		references: [matiere.idMatiere]
	}),
}));

export const absenceRelations = relations(absence, ({one}) => ({
	eleve: one(eleve, {
		fields: [absence.idEleve],
		references: [eleve.idEleve]
	}),
}));

export const resultatRelations = relations(resultat, ({one}) => ({
	evaluation: one(evaluation, {
		fields: [resultat.idEvaluation],
		references: [evaluation.idEvaluation]
	}),
	eleve: one(eleve, {
		fields: [resultat.idEleve],
		references: [eleve.idEleve]
	}),
}));

export const visiteRelations = relations(visite, ({one}) => ({
	intervention: one(intervention, {
		fields: [visite.idIntervention],
		references: [intervention.idIntervention]
	}),
	eleve: one(eleve, {
		fields: [visite.idEleve],
		references: [eleve.idEleve]
	}),
}));

export const presenceActiviteRelations = relations(presenceActivite, ({one}) => ({
	eleve: one(eleve, {
		fields: [presenceActivite.idEleve],
		references: [eleve.idEleve]
	}),
	activiteExtra: one(activiteExtra, {
		fields: [presenceActivite.idActivite],
		references: [activiteExtra.idActivite]
	}),
}));

export const activiteExtraRelations = relations(activiteExtra, ({many}) => ({
	presenceActivites: many(presenceActivite),
	profActis: many(profActi),
}));

export const profActiRelations = relations(profActi, ({one}) => ({
	enseignant: one(enseignant, {
		fields: [profActi.idEnseignant],
		references: [enseignant.idEnseignant]
	}),
	activiteExtra: one(activiteExtra, {
		fields: [profActi.idActivite],
		references: [activiteExtra.idActivite]
	}),
}));

export const presenceReunionRelations = relations(presenceReunion, ({one}) => ({
	enseignant: one(enseignant, {
		fields: [presenceReunion.idEnseignant],
		references: [enseignant.idEnseignant]
	}),
	reunion: one(reunion, {
		fields: [presenceReunion.idReunion],
		references: [reunion.idReunion]
	}),
}));

export const ligneCommandeRelations = relations(ligneCommande, ({one}) => ({
	commande: one(commande, {
		fields: [ligneCommande.idCommande],
		references: [commande.idCommande]
	}),
	fourniture: one(fourniture, {
		fields: [ligneCommande.idProduit],
		references: [fourniture.idProduit]
	}),
}));

export const fournitureRelations = relations(fourniture, ({many}) => ({
	ligneCommandes: many(ligneCommande),
}));

export const conseilEleveRelations = relations(conseilEleve, ({one}) => ({
	conseilDeClasse: one(conseilDeClasse, {
		fields: [conseilEleve.idConseil],
		references: [conseilDeClasse.idConseil]
	}),
	eleve: one(eleve, {
		fields: [conseilEleve.idEleve],
		references: [eleve.idEleve]
	}),
}));