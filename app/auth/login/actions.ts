"use server";
import bcrypt from "bcryptjs";
import { redirect } from "next/navigation";
import { and, eq, gt } from "drizzle-orm";
import { createSession, deleteSession } from "@/lib/session";
import { orm } from "@/lib/drizzle";
import { users } from "@/drizzle/schema";

const ACCUEIL_PAR_ROLE: Record<string, string> = {
  direction: "/dashboard",
  secretariat: "/dashboard",
  enseignant: "/espace-enseignant",
  paramedical: "/espace-paramedical",
  tuteur: "/espace-tuteur",
  eleve: "/espace-eleve",
};

export async function login(_etat: { erreur?: string }, formData: FormData) : Promise<{ erreur?: string }> {
  const email = String(formData.get("email") ?? "").trim().toLowerCase();
  const motDePasse = String(formData.get("password") ?? "");

  const [user] = await orm
    .select({ id: users.id, role: users.role, passwordHash: users.passwordHash, actif: users.actif })
    .from(users)
    .where(eq(users.email, email))
    .limit(1);

  const ok = await bcrypt.compare(motDePasse, user.passwordHash);

  await createSession(user.id);
  redirect(ACCUEIL_PAR_ROLE[user.role]);
}

export async function logout() {
  await deleteSession();
  redirect("/login");
}