import { config } from "dotenv";
import { defineConfig } from "drizzle-kit";

config({ path: ".env.local" }); // charge DATABASE_URL pour drizzle-kit

export default defineConfig({
  dialect: "postgresql",
  out: "./drizzle",            // pull y écrit schema.ts ; plus tard, les migrations
  schema: "./drizzle/schema.ts",
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
    introspect: {
    casing: "camel",
  },   // id_user → idUser côté TypeScript
});