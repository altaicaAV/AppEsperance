import "server-only";
import nodemailer from "nodemailer";

const transporteur = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: Number(process.env.SMTP_PORT),
  secure: false,
});

export async function envoyerMail(destinataire: string, sujet: string, html: string) {
    const mailOptions = {
        from: process.env.MAIL_FROM,
        to: destinataire,
        subject: sujet,
        html: html,
    };
    return transporteur.sendMail(mailOptions);
}