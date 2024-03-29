/*
 * This function return a list of random words pick in word_list
 * @Param int Length of the returned list
 */
import 'dart:math';

Random randomIndex = Random();
List getRandomWords(int listLength) {
  var finalList = [];
  for (var i = 0; i < listLength; i++) {
    finalList.add((word_list.toList()..shuffle()).first);
  }
  return finalList;
}

String getRandomWord() {
  return word_list.elementAt(randomIndex.nextInt(word_list.length));
}

// ~480 words in total without accents or conjugated verbs
const List<String> word_list = [
  "abandonner",
  "accepter",
  "accompagner",
  "accord",
  "acheter",
  "adorer",
  "affaire",
  "agent",
  "agir",
  "aide",
  "aider",
  "aimer",
  "ajouter",
  "aller",
  "amener",
  "amour",
  "amuser",
  "ancien",
  "annoncer",
  "apercevoir",
  "appel",
  "appeler",
  "apporter",
  "apprendre",
  "approcher",
  "arbre",
  "argent",
  "arme",
  "arranger",
  "arriver",
  "asseoir",
  "assurer",
  "attaquer",
  "atteindre",
  "attendre",
  "attention",
  "autre",
  "avancer",
  "avenir",
  "avion",
  "avis",
  "avoir",
  "baisser",
  "balle",
  "bateau",
  "battre",
  "beau",
  "besoin",
  "bizarre",
  "blanc",
  "bleu",
  "boire",
  "bois",
  "bonheur",
  "bonjour",
  "bonne",
  "bord",
  "bouche",
  "bouger",
  "boulot",
  "bout",
  "bras",
  "bruit",
  "bureau",
  "cacher",
  "calmer",
  "camp",
  "capitaine",
  "carte",
  "casser",
  "cause",
  "certain",
  "cesser",
  "chambre",
  "chance",
  "changer",
  "chanter",
  "charger",
  "chat",
  "chaud",
  "chef",
  "chemin",
  "cher",
  "chercher",
  "cheval",
  "cheveu",
  "chien",
  "choisir",
  "choix",
  "chose",
  "ciel",
  "clair",
  "classe",
  "client",
  "coeur",
  "coin",
  "colonel",
  "commencer",
  "comprendre",
  "compte",
  "compter",
  "conduire",
  "confiance",
  "content",
  "continuer",
  "copain",
  "corps",
  "coucher",
  "couleur",
  "coup",
  "couper",
  "cour",
  "courant",
  "courir",
  "cours",
  "couvrir",
  "craindre",
  "crier",
  "croire",
  "cuisine",
  "dame",
  "danser",
  "demander",
  "dent",
  "dernier",
  "descendre",
  "devenir",
  "deviner",
  "devoir",
  "dieu",
  "difficile",
  "dire",
  "docteur",
  "doigt",
  "dollar",
  "donner",
  "dormir",
  "doute",
  "doux",
  "droit",
  "droit",
  "droite",
  "effet",
  "embrasser",
  "emmener",
  "emporter",
  "endroit",
  "enfant",
  "enlever",
  "ennemi",
  "entendre",
  "entier",
  "entrer",
  "envie",
  "envoyer",
  "erreur",
  "escalier",
  "esprit",
  "essayer",
  "excuser",
  "exemple",
  "exister",
  "expliquer",
  "face",
  "facile",
  "faim",
  "faire",
  "fait",
  "falloir",
  "famille",
  "faute",
  "faux",
  "femme",
  "fermer",
  "filer",
  "fille",
  "film",
  "fils",
  "finir",
  "fleur",
  "flic",
  "fois",
  "fond",
  "force",
  "forme",
  "fort",
  "foutre",
  "frapper",
  "froid",
  "front",
  "gagner",
  "garde",
  "garder",
  "gars",
  "gauche",
  "genre",
  "gens",
  "gentil",
  "geste",
  "glisser",
  "gosse",
  "gouvernement",
  "grand",
  "grave",
  "gros",
  "groupe",
  "guerre",
  "gueule",
  "habiter",
  "habitude",
  "haut",
  "heure",
  "heureux",
  "histoire",
  "homme",
  "honneur",
  "humain",
  "ignorer",
  "image",
  "imaginer",
  "important",
  "importer",
  "impossible",
  "impression",
  "installer",
  "instant",
  "inviter",
  "jambe",
  "jardin",
  "jeter",
  "jeune",
  "joie",
  "joli",
  "jouer",
  "jour",
  "journal",
  "jurer",
  "juste",
  "laisser",
  "lancer",
  "langue",
  "lettre",
  "lever",
  "libre",
  "lieu",
  "ligne",
  "lire",
  "long",
  "madame",
  "main",
  "maintenir",
  "maison",
  "malade",
  "maman",
  "manger",
  "manquer",
  "marche",
  "marcher",
  "mari",
  "mariage",
  "marier",
  "matin",
  "mauvais",
  "meilleur",
  "mener",
  "mentir",
  "merci",
  "merde",
  "mettre",
  "milieu",
  "million",
  "minute",
  "mois",
  "moment",
  "monde",
  "monsieur",
  "monter",
  "montrer",
  "mort",
  "mourir",
  "mouvement",
  "moyen",
  "musique",
  "noir",
  "nouveau",
  "nuit",
  "obliger",
  "occuper",
  "odeur",
  "oeil",
  "offrir",
  "oiseau",
  "ombre",
  "oncle",
  "ordre",
  "oreille",
  "oser",
  "oublier",
  "ouvrir",
  "paix",
  "papa",
  "papier",
  "pareil",
  "parent",
  "parler",
  "parole",
  "part",
  "partie",
  "partir",
  "passage",
  "passer",
  "patron",
  "pauvre",
  "payer",
  "pays",
  "peau",
  "peine",
  "penser",
  "perdre",
  "permettre",
  "personne",
  "petit",
  "peuple",
  "peur",
  "photo",
  "pied",
  "pierre",
  "place",
  "plaire",
  "plaisir",
  "plan",
  "plein",
  "pleurer",
  "poche",
  "point",
  "police",
  "porte",
  "porter",
  "poser",
  "possible",
  "pousser",
  "pouvoir",
  "pouvoir",
  "premier",
  "prendre",
  "prier",
  "prince",
  "prison",
  "prix",
  "prochain",
  "professeur",
  "promettre",
  "propos",
  "proposer",
  "propre",
  "putain",
  "quartier",
  "question",
  "quitter",
  "quoi",
  "raconter",
  "raison",
  "ramener",
  "rappeler",
  "rapport",
  "recevoir",
  "refuser",
  "regard",
  "regarder",
  "rejoindre",
  "remarquer",
  "remettre",
  "remonter",
  "rencontrer",
  "rendre",
  "rentrer",
  "reposer",
  "reprendre",
  "ressembler",
  "reste",
  "rester",
  "retard",
  "retenir",
  "retirer",
  "retour",
  "retourner",
  "retrouver",
  "revenir",
  "revoir",
  "revoir",
  "rire",
  "risquer",
  "robe",
  "rouge",
  "rouler",
  "route",
  "sale",
  "salle",
  "salut",
  "sang",
  "sauter",
  "sauver",
  "savoir",
  "seconde",
  "secret",
  "seigneur",
  "semaine",
  "sembler",
  "sens",
  "sentiment",
  "sentir",
  "serrer",
  "service",
  "servir",
  "seul",
  "signe",
  "silence",
  "simple",
  "situation",
  "soeur",
  "soir",
  "soldat",
  "soleil",
  "sorte",
  "sortir",
  "souffrir",
  "sourire",
  "sourire",
  "souvenir",
  "souvenir",
  "suffire",
  "suite",
  "suivre",
  "sujet",
  "super",
  "table",
  "taire",
  "temps",
  "tendre",
  "tenir",
  "tenter",
  "terminer",
  "terre",
  "tirer",
  "tomber",
  "toucher",
  "tour",
  "tourner",
  "tout",
  "toute",
  "train",
  "traiter",
  "tranquille",
  "travail",
  "travailler",
  "travers",
  "traverser",
  "triste",
  "tromper",
  "trou",
  "trouver",
  "truc",
  "tuer",
  "type",
  "utiliser",
  "valoir",
  "vendre",
  "venir",
  "vent",
  "ventre",
  "verre",
  "vert",
  "vide",
  "vieux",
  "village",
  "ville",
  "visage",
  "vivant",
  "vivre",
  "voir",
  "voiture",
  "voix",
  "voler",
  "voyage",
  "vrai",
];
