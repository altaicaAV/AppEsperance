"use client";
import { useActionState } from "react";
import { demanderReinitialisation } from "./actions";

export default function motDePasseOublie() {
  const [etat, action, enCours] = useActionState(demanderReinitialisation, {});
    return (
        <div className="flex w-full md:w-1/3 h:auto flex-col items-center justify-center gap-6 px-16 py-32">
            <form action={action} className="flex w-full flex-col gap-4">
                <label htmlFor="email" className="text-sm font-medium">Adresse e-mail</label>
                <input name="email" type="email" required className="..." />

                {etat.erreur && <p className="text-red-600 text-sm">{etat.erreur}</p>}
                {etat.message && <p className="text-green-600 text-sm">{etat.message}</p>}

                <button type="submit" disabled={enCours} className="...">
                    {enCours ? "Envoi..." : "Envoyer le lien"}
                </button>
            </form>
        </div>
    )
}