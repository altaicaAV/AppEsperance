import { envoyerMail } from "@/lib/mail";

export async function GET() {
  try {
    await envoyerMail("test@esperance.be", "Test Mailpit", "<p>Ça fonctionne</p>");
    return Response.json({ ok: true });
  } catch (e) {
    console.error(e);
    return Response.json({ ok: false, erreur: String(e) }, { status: 500 });
  }
}