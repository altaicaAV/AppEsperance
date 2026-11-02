import "server-only";
import { drizzle } from "drizzle-orm/node-postgres";
import { db as pool } from "@/lib/db";          // ton Pool existant, renommé ici
import * as schema from "@/drizzle/schema";
import * as relations from "@/drizzle/relations";

export const orm = drizzle({
  client: pool,
  schema: { ...schema, ...relations },
});