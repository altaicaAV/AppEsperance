import "server-only";
import { cookies } from "next/headers";
import { randomBytes, createHash } from "crypto";
import { db } from "@/lib/db";
import { and, eq, gt } from "drizzle-orm";
import { orm } from "@/lib/drizzle";
import { session, users } from "@/drizzle/schema";

const COOKIE = "session";
const DUREE_MS = 1000 * 60 * 60 * 8; // 8 heures

function hacher(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

export async function createSession(idUser: number) {
  const token = randomBytes(32).toString("base64url");
  const expiresAt = new Date(Date.now() + DUREE_MS);

  await orm.insert(session).values({
    idSession: hacher(token),
    idUser,
    expiresAt,
  });

  (await cookies()).set(COOKIE, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "lax",
    path: "/",
    expires: expiresAt,
  });
}

export async function getSession() {
  const token = (await cookies()).get(COOKIE)?.value;
  if (!token) return null;

  const [resultat] = await orm
    .select({ id: users.id, role: users.role, email: users.email })
    .from(session)
    .innerJoin(users, eq(session.idUser, users.id))
    .where(and(
      eq(session.idSession, hacher(token)),
      gt(session.expiresAt, new Date()),
      eq(users.actif, true)
    ));

  return resultat ?? null;
}

export async function deleteSession() {
  const token = (await cookies()).get(COOKIE)?.value;
  if (token) {
    await orm.delete(session).where(eq(session.idSession, hacher(token)));
  }
  (await cookies()).delete(COOKIE);
}