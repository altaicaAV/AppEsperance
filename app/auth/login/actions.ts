"use server";
import bcrypt from "bcryptjs";
import { redirect } from "next/navigation";
import { db } from "@/lib/db";
import { createSession, deleteSession } from "@/lib/session";

const ACCUEIL_PAR_ROLE: Record<string, string> = {
  direction: "/dashboard",
  secretariat: "/dashboard",
  enseignant: "/espace-enseignant",
  paramedical: "/espace-paramedical",
  tuteur: "/espace-tuteur",
  eleve: "/espace-eleve",
};

export async function login(_etat: { erreur?: string }, formData: FormData) {
  const email = String(formData.get("email") ?? "").trim().toLowerCase();
  const motDePasse = String(formData.get("password") ?? "");

  const { rows } = await db.query(
    "SELECT id, role, password_hash, actif FROM users WHERE email = $1",
    [email]
  );
  const user = rows[0];

  // Même message dans tous les cas : on ne révèle pas si l'email existe
  if (!user || !user.actif || !(await bcrypt.compare(motDePasse, user.password_hash))) {
    return { erreur: "Email ou mot de passe incorrect." };
  }

  await createSession(user.id);
  redirect(ACCUEIL_PAR_ROLE[user.role]);
}

export async function logout() {
  await deleteSession();
  redirect("/login");
}