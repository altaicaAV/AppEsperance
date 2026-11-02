"use client";
import { useActionState } from "react";
import { login } from "./actions";
import Image from "next/image";

export default function LoginPage() {
  const [etat, action, enCours] = useActionState(login, {});

  return (
    <div className="flex min-h-screen bg-white text-black">
      <div className="hidden md:block w-2/3 relative">
        <Image
          src="/classe.jpg"
          alt="Photo de l'école"
          fill
          className="object-cover"
        />
      </div>
      <div className="flex w-full md:w-1/3 h:auto flex-col items-center justify-center gap-6 px-16 py-32">
        <Image
          src="/esperance.png"
          alt="Logo de l'école L'Espérance"
          width={120}
          height={60}
        />
        <form action={action} className="flex w-full flex-col gap-4">
          <input name="email" type="email" required className="border border-gray-300 rounded px-4 py-2" />
          <input name="password" type="password" required className="border border-gray-300 rounded px-4 py-2" />

          {etat.erreur && <p className="text-red-600 text-sm">{etat.erreur}</p>}

          <button type="submit" disabled={enCours} className="bg-blue-600 text-white px-4 py-2 rounded disabled:opacity-50">
            {enCours ? "Connexion..." : "Se connecter"}
          </button>
        </form>
      </div>
    </div>
  )
}