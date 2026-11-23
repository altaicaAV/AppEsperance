"use server";

type EtatReinitialisation = { erreur?: string; message?: string };

export async function demanderReinitialisation(
  _etatPrecedent: EtatReinitialisation,
  formData: FormData
): Promise<EtatReinitialisation> {
  // TODO: la logique (squelette d'avant)
  return { message: "Si un compte existe pour cette adresse, un email a été envoyé." };
}