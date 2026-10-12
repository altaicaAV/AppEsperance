import "server-only";
import { cookies } from "next/headers";
import { randomBytes, createHash } from "crypto";
import { db } from "@/lib/db";

const COOKIE = "session";
const DUREE_MS = 1000 * 60 * 60 * 8; // 8 heures

function hacher(token: string) {
  return createHash("sha256").update(token).digest("hex");
}

export async function createSession(idUser: number) {
  const token = randomBytes(32).toString("base64url");
  const expiresAt = new Date(Date.now() + DUREE_MS);

  await db.query(
    "INSERT INTO session (id_session, id_user, expires_at) VALUES ($1, $2, $3)",
    [hacher(token), idUser, expiresAt]
  );

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

  const { rows } = await db.query(
    `SELECT u.id, u.role, u.email
       FROM session s JOIN users u ON u.id = s.id_user
      WHERE s.id_session = $1
        AND s.expires_at > NOW()
        AND u.actif = TRUE`,
    [hacher(token)]
  );
  return rows[0] ?? null; // { id, role, email } ou null
}

export async function deleteSession() {
  const token = (await cookies()).get(COOKIE)?.value;
  if (token) {
    await db.query("DELETE FROM session WHERE id_session = $1", [hacher(token)]);
  }
  (await cookies()).delete(COOKIE);
}