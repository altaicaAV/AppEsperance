import Image from "next/image";

export default function LoginPage() {
    <div className="flex min-h-screen bg-white text-black">
      <div className="hidden md:block w-2/3 relative">
        <Image
          src="/classe.jpg"
          alt="Photo de l'école"
          fill
          className="object-cover"
        />
      </div>
      <div className="flex w-full md:w-1/3 flex-col items-center justify-center gap-6 px-16 py-32">
        <Image
          src="/logo-ecole.svg"
          alt="Logo de l'école L'Espérance"
          width={120}
          height={60}
        />
        <form className="flex flex-col gap-4 w-full">
          <input
            type="email"
            placeholder="Email"
            className="border border-gray-300 rounded px-4 py-2"
          />
          <input
            type="password"
            placeholder="Mot de passe"
            className="border border-gray-300 rounded px-4 py-2"
          />
          <button
            type="submit"
            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
          >
            Se connecter
          </button>
        </form>
      </div>
    </div>
}