# -*- coding: utf-8 -*-
"""
Created on Mon Oct  7 16:20:26 2024
VoCare project
@author: lucas
"""

import speech_recognition as sr
import pyttsx3
import os
import mysql.connector
from mysql.connector import Error
import logging

# Configurer le logging
logging.basicConfig(level=logging.INFO)

# Initialisation du moteur de synthèse vocale
engine = pyttsx3.init()
recognizer = sr.Recognizer()

# Chemin du dossier de stockage des enregistrements
os.makedirs("enregistrements", exist_ok=True)

def insert_into_database(text):
    """Fonction pour insérer du texte dans la base de données."""
    try:
        # Connexion à la base de données MySQL
        connection = mysql.connector.connect(
            host='localhost',
            database='epsi',  # Nom de la base de données
            user='lucas',     # Nom d'utilisateur
            password='lucas'  # Mot de passe
        )
        if connection.is_connected():
            logging.info("Connexion réussie à la base de données")
            # Préparer la requête SQL pour l'insertion
            query = "INSERT INTO info (test) VALUES (%s)"
            values = (text,)  # Tuple pour l'insertion

            with connection.cursor() as cursor:
                cursor.execute(query, values)
                connection.commit()
                logging.info(f"{cursor.rowcount} ligne insérée dans la base de données.")
    except Error as e:
        logging.error(f"Erreur lors de la connexion à MySQL : {e}")
    finally:
        if connection.is_connected():
            connection.close()
            logging.info("Connexion MySQL fermée.")

def start_recording():
    """Fonction pour démarrer l'enregistrement vocal."""
    global recording, enregistrement_id
    recording = True
    engine.say("Enregistrement commencé.")
    engine.runAndWait()
    return f"enregistrements/enregistrement{enregistrement_id}.txt"

def stop_recording(filename, text):
    """Fonction pour arrêter l'enregistrement."""
    global recording, enregistrement_id
    recording = False
    engine.say("Enregistrement terminé.")
    engine.runAndWait()

    with open(filename, "a", encoding="utf-8") as f:
        f.write(text + "\n")
    
    logging.info(f"Enregistrement terminé et sauvegardé dans {filename}")
    insert_into_database(text)
    enregistrement_id += 1

def main():
    global recording, enregistrement_id
    recording = False
    enregistrement_id = 1

    while True:
        try:
            with sr.Microphone() as mic:
                recognizer.adjust_for_ambient_noise(mic, duration=0.2)

                if not recording:
                    logging.info("Dites 'début' pour commencer l'enregistrement...")
                else:
                    logging.info("Enregistrement en cours... Dites 'stop' pour terminer cet enregistrement.")

                audio = recognizer.listen(mic)

                try:
                    text = recognizer.recognize_google(audio, language="fr-FR")
                except sr.UnknownValueError:
                    logging.warning("Je n'ai pas compris, essayez encore.")
                    continue

                text = text.lower()
                logging.info(f"Reconnu : {text}")

                if not recording:
                    if "début" in text:
                        filename = start_recording()
                    else:
                        logging.warning("Le mot 'début' n'a pas été détecté.")
                else:
                    if "stop" in text:
                        stop_recording(filename, text)
                        break  # Terminer le script après l'insertion
                    else:
                        with open(filename, "a", encoding="utf-8") as f:
                            f.write(text + "\n")
                        engine.say(f"Vous avez dit {text}")
                        engine.runAndWait()

        except sr.RequestError as e:
            logging.error(f"Erreur de requête au service Google ; {e}")
            engine.say("Erreur de requête au service Google.")
            engine.runAndWait()
            break

        except Exception as e:
            logging.error(f"Une erreur est survenue : {e}")
            engine.say(f"Une erreur est survenue : {e}")
            engine.runAndWait()
            break

if __name__ == "__main__":
    main()
