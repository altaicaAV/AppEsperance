import "server-only";
import { Pool } from "pg";

const globalPourPg = globalThis as unknown as { pool?: Pool };

export const db =
  globalPourPg.pool ??
  new Pool({
    connectionString: process.env.DATABASE_URL,
  });

if (process.env.NODE_ENV !== "production") {
  globalPourPg.pool = db;
}