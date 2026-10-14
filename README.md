# Portfolio Académique & Projets Personnels — Aïssa Kahloul

Bienvenue sur ce dépôt regroupant l'ensemble de mes travaux pratiques, projets universitaires et développements personnels réalisés au cours de mon cursus en informatique, du **DUT Informatique** jusqu'au **Master 2 Informatique (spécialisation Intelligence Artificielle)**.

---

## Sélection de Projets Phares (Accès Rapide)

Pour parcourir rapidement les réalisations les plus représentatives :

- **[Architectures de Réseaux de Neurones & Deep Learning (M2)](./M2/ArchiRN)** : Implémentations PyTorch de réseaux profonds (MLP, CNN, segmentation d'images, Graph Neural Networks sur le dataset ENZYMES et NLP).
- **[Apprentissage par Renforcement / Reinforcement Learning (M2)](./M2/RL)** : Résolution de Processus de Décision Markoviens (MDP), méthodes tabulaires, Q-Learning et agents sans modèle sur *GridWorld* et *MountainCar*.
- **[IA Explicable / XAI & Green AI (M2)](./M2/XAI)** : Interprétabilité des modèles (cartes de saillance, modèles boîte blanche) et **[évaluation de l'empreinte carbone](./M2/AISustain)** de modèles de diffusion (DDPM) avec *CodeCarbon*.
- **[Mod NSMBWii & Intégration Twitch Interactive (Perso)](./Perso/NSMBW_CC)** : Projet mêlant un **[bot Twitch en Python](./Perso/NSMBW_CC/Bot_Twitch_Mario)** et du **[code C++ injecté via Kamek](./Perso/NSMBW_CC/Projet_Wii_Twitch)** dans le jeu *New Super Mario Bros. Wii* pour permettre aux spectateurs d'interagir en direct avec la partie.
- **[Solveur SAT, Planification & Raisonnement Automatique (M1)](./M1/S8/Raisonnement)** : Implémentation d'un solveur SAT en Python (résolution de Sudoku, monde du Wumpus), systèmes experts, planification PDDL et programmation logique par ensembles réponses (ASP).
- **[Compilateur OCaml & Preuves Formelles Coq (L3)](./L3)** : Développement d'un **[interpréteur/compilateur AST](./L3/Compilation)** avec Dune et **[démonstrations formelles en logique](./L3/Logique&Preuve)** sous l'assistant de preuve Coq.

---

## Compétences & Technologies Mobilisées

| Domaine | Technologies, Langages & Outils |
| :--- | :--- |
| **Intelligence Artificielle & Data** | Python, PyTorch, Scikit-Learn, NumPy, Pandas, Jupyter, CodeCarbon, Tulip (.tlp) |
| **Raisonnement & Logique Formelle** | Answer Set Programming (Clingo / Gringo), PDDL, Solveurs SAT (CNF), Assistant de preuve Coq |
| **Développement Logiciel & Système** | C, C++, Java (Maven, Swing/POO), OCaml (Dune, OPAM), Bash / Shell POSIX |
| **Web & Bases de Données** | SQL (PostgreSQL / MySQL), HTML/CSS, JavaScript, PHP, Modélisation MEA / Looping |
| **Outils & Ingénierie** | Git, CMake, Makefile, Doxygen, Linux / POSIX, Injection binaire PowerPC (Kamek) |

---

## Guide de Navigation par Niveau

Le dépôt est structuré chronologiquement et thématiquement en **5 répertoires principaux** :

### 1. [./M2](./M2) — Master 2 Informatique (Spécialité IA)

Approfondissement des architectures modernes d'apprentissage, de la représentation des connaissances et de l'analyse de réseaux complexes :

- **[ArchiRN/](./M2/ArchiRN)** : Architectures de Réseaux de Neurones — MLP, CNN, segmentation d'images (TD_Segmentation), Graph Neural Networks (cours04) et traitement du langage naturel (TP-20261007).
- **[RL/](./M2/RL)** : Reinforcement Learning — Bandits manchots, programmation dynamique (Value/Policy Iteration), algorithmes Model-Free et environnements *GridWorld* / *MountainCar*.
- **[XAI/](./M2/XAI)** : Explainable AI — Étude de l'explicabilité des modèles d'apprentissage profond, extraction de représentations et cartes de saillance (*Saliency Maps*).
- **[AISustain/](./M2/AISustain)** : IA Durable — Inférence et fine-tuning de modèles de diffusion (*DDPM Butterflies*) avec mesure de la consommation énergétique GPU et des émissions carbone via *CodeCarbon*.
- **[KR/](./M2/KR)** : Knowledge Representation — Programmation déclarative en **ASP (Answer Set Programming)** avec *Clingo* (graphes causaux, recherche de cliques, généalogie).
- **[SdDR/](./M2/SdDR)** : Science des Données et des Réseaux — Théorie des graphes et réseaux complexes (algorithme de Havel-Hakimi, modèles aléatoires d'Erdős–Rényi et Watts-Strogatz, mesures de centralité, projection de graphes bipartis).

---

### 2. [./M1](./M1) — Master 1 Informatique

Fondements théoriques et pratiques de l'IA, de l'algorithmique avancée et des systèmes d'exploitation :

- **[S8/DLandML/](./M1/S8/DLandML)** : Deep Learning & Machine Learning — Manipulation de tenseurs et entraînement de réseaux convolutifs sous PyTorch (classification sur CIFAR-10).
- **[S8/Raisonnement/](./M1/S8/Raisonnement)** : Raisonnement Automatique — Développement d'un solveur SAT complet (pysat.py), résolution du Sudoku par clauses CNF, agent logique dans le *Wumpus World*, systèmes experts, parseur PDDL, algorithmes génétiques (TSP) et ASP.
- **[S8/BD/](./M1/S8/BD)** : Bases de Données Avancées — Conception de schémas relationnels et requêtes SQL complexes.
- **[S7/ACID/](./M1/S7/ACID)** : Analyse, Classification et Indexation des Données — Implémentation des algorithmes classiques de Machine Learning (Descente de gradient, Régression, KNN, Classifieur Bayésien, Arbres de décision, Random Forests, SVM).
- **[S7/CoCa/](./M1/S7/CoCa)** : Complexité et Calculabilité — Solveur de problèmes de graphes en **C++** structuré avec CMake et documenté sous Doxygen.
- **[S7/OS/](./M1/S7/OS) & [S7/Nachos/](./M1/S7/Nachos)** : Systèmes d'Exploitation — Travaux sur le noyau éducatif **NachOS** (gestion des threads, appels système et synchronisation).
- **[S7/ProjetPoo/](./M1/S7/ProjetPoo) & [S7/Objet/](./M1/S7/Objet)** : Conception et Programmation Orientée Objet avancée.

---

### 3. [./Perso](./Perso) — Projets Personnels

Projets développés en autonomie autour du modding de jeux vidéo et de l'automatisation :

- **[NSMBW_CC/](./Perso/NSMBW_CC)** : *New Super Mario Bros. Wii Crowd Control* :
  - **[Bot_Twitch_Mario/](./Perso/NSMBW_CC/Bot_Twitch_Mario)** : Bot Twitch en Python récupérant et filtrant les commandes du chat en temps réel.
  - **[Projet_Wii_Twitch/](./Perso/NSMBW_CC/Projet_Wii_Twitch)** : Code C++ compilé et injecté dans le binaire du jeu Wii via l'outil *Kamek* (linker.x, configurations YAML) pour modifier dynamiquement le comportement du jeu.
- **[ResetMapOnDeath/](./Perso/ResetMapOnDeath)** : Plugin serveur **Minecraft** développé en Java (Maven) réinitialisant automatiquement le monde lorsqu'un joueur meurt (conçu pour les défis *Hardcore* multijoueurs).

---

### 4. [./L3](./L3) — Licence 3 Informatique

Focus sur l'informatique fondamentale, la programmation système bas niveau et les langages fonctionnels :

- **[Compilation/](./L3/Compilation)** : Réalisation d'un analyseur, interpréteur d'arbre syntaxique abstrait (AST) et compilateur en **OCaml** (géré avec Dune et OPAM).
- **[Logique&Preuve/](./L3/Logique&Preuve)** : Démonstrations formelles assistées par ordinateur avec **Coq** (logique minimale, intuitionniste et classique).
- **[ProgFonctionnelle/](./L3/ProgFonctionnelle)** : Travaux pratiques en **OCaml** (récursivité, structures de données immuables, manipulation de graphes).
- **[progsys/](./L3/progsys)** : Programmation Système en **C (POSIX)** — Création d'un interpréteur de commandes (Minishell), gestion des processus (fork, exec), tubes de communication (pipe), signaux, entrées/sorties bas niveau et parallélisme (easypap, problème des N-Reines).
- **[ProjetDev/](./L3/ProjetDev)** : Projet de développement d'application Full-Stack (Backend Java/Maven, Frontend Web et traitement d'images).
- **[TechniqueAlgoProg/](./L3/TechniqueAlgoProg)** : Implémentation de structures de données en C (files de priorité / tas binaires heap).

---

### 5. [./IUTINFO](./IUTINFO) — DUT Informatique (S1 à S4) & LP DAWIN

Appprofondissement des fondamentaux du génie logiciel, de l'algorithmique et des réseaux :

- **Projets Orientés Objet (Java)** : Développement complet des jeux **[Sokoban](./IUTINFO/S2/ProjetSOKOBAN)** et **[Gomoku](./IUTINFO/S2/ProjetPOO/Gomoku)**, projets d'IHM et d'architecture logicielle (**[CPOA](./IUTINFO/S3/CPOA)**, **[PT3](./IUTINFO/S3/PT3)**, **[PT4](./IUTINFO/S4/PT4)**).
- **Algorithmique, Système & Web** : Premiers pas en algorithmique (Java, Processing, C), scripts système Bash, bases de données relationnelles (ACSI/SQL) et développement Web (**[LP DAWIN](./IUTINFO/LP_Dawin)** : Java, PHP, authentification).