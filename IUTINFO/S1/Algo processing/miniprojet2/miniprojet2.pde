/**  //<>//
 * Lorsque c'est possible, transformez chaque boucle for en while (ou inversement).
 */
void exercice0() {

  // initialisation du tableau, au début de l'exercice, commun à toutes les boucles
  int [] t = new int [10];
  for (int i=0; i<10; i++) { // on ne demande pas de transformer cette boucle
    t[i] = (int)random(0, 20);
  }

  // Boucle 1 :

  // version for :
  int s1 = 0;
  for (int i=0; i<10; i++) {
    s1 += t[i];
  }
  // version while :
  int s2 = 0;
  int i2 = 0;
  while (i2 < 10) {
    s2 += t[i2];
    ++i2;
  }
  assert s1==s2;

  // Boucle 2

  // version for :
  int s3 = 0;
  for (int i=9; i>=0; i--) {
    s3 += t[i];
  }
  // version while :
  int s4 = 0;
  int i4 = 9;
  while (i4 >= 0) {
    s4 += t[i4];
    --i4;
  }
  assert s3==s4;

  // Boucle 3

  float val;
  // version while :
  val = random(0, 10);
  while ((int)val < 5) {
    val = random(0, 10);
  }
  // version for :
  for (val = random(0, 10); (int)val < 5; val = random(0, 10)) {
    
  }
  
  // Boucle 4

  int nombre1 = (int)random(0, 100);
  int nombre2 = (int)random(nombre1, 100);
  // version while :
  int depart = nombre1;
  int sommeWhile = 0;
  while (depart < nombre2) {
    sommeWhile += depart;
    depart++;
  }
  // version for :
  int sommeFor = 0;
  for (int depart2 = nombre1; depart2 < nombre2; ++depart2) {
    sommeFor += depart2;
  }
  assert sommeWhile == sommeFor;

  // Boucle 5

  int nombre3 = (int)random(1, 100);
  // version for :
  int p = 1;
  for (int i=nombre3-1; i>0; i--) {
    p *= i;
  }
  // version while :
  int q = 1;
  int j = nombre3 - 1;
  while (j > 0) {
    q *= j;
    --j;
  }
  assert p == q;

  // Boucle 6

  int nombre4 = (int)random(1, 50);
  int nombre5 = (int)random(nombre4+1, 100);
  // version while :
  while (nombre5 < nombre4) {
    nombre5 = (int)random(nombre4, 100);
  }
  // version for :
  for (nombre5 = (int)random(nombre4 + 1, 100); nombre5 < nombre4; nombre5 = (int)random(nombre4, 100)) {
    
  }
}



/**
 * Chaque boucle est supposée afficher le nombre d'entiers pairs contenus dans le tableau.
 * Identifiez les boucles qui ne donnent pas le résultat escompté. 
 * Corrigez chaque erreur.
 */
void exercice1() {
  int tab[] = {4, 4, 2, 9, 15, 10, 12};
  int TAILLE = 7;
  int nbEntiersPairs;
  int indice;

  // Boucle 1

  
  nbEntiersPairs = 0;
  for (int i=0; i < TAILLE; i++) {
    if (tab[i]%2 == 0) {
      nbEntiersPairs++;
    }
  }
  assert nbEntiersPairs == 5;
  

  // Boucle 2

  
  nbEntiersPairs = 0;
  for(int i=0; i<TAILLE; i++) {
    if (tab[i]%2 == 0) {
      nbEntiersPairs++;
    }
  }
  assert nbEntiersPairs == 5;
  

  // Boucle 3

  
  nbEntiersPairs = 0;
  for (int i=TAILLE-1; i>=0; i--) {
    if (tab[i]%2 == 0) {
      nbEntiersPairs++;
    }
  }
  assert nbEntiersPairs == 5;
  

  // Boucle 4

  
  nbEntiersPairs = 0;
  for (int i=0; i<TAILLE*2; i+=2) {
    if (tab[i/2]%2 == 0) {
      nbEntiersPairs++;
    }
  }
  assert nbEntiersPairs == 5;
  

  // Boucle 5
  
  
  nbEntiersPairs = 0;
  indice = 0;
  while (indice <= TAILLE-1) {
    if (tab[indice]%2 == 0) {
      nbEntiersPairs++;
    }
    indice++;
  }
  assert nbEntiersPairs == 5;
  

  // Boucle 6
  
  
  nbEntiersPairs = 0;
  indice = 0; 
  while (indice < TAILLE) {
    if (tab[indice]%2 == 0) {
      nbEntiersPairs++;
    }
    indice++;
  }
  assert nbEntiersPairs == 5;
  
}

/**
 * Écrire avec une boucle for le code permettant de compter le nombre d'entiers impairs.
 */
void exercice2() {
  int tab[] = {4, 4, 2, 9, 15, 10, 12};
  int TAILLE = 7;
  int nbEntiersImpairs = 0;

  for (int i = 0; i < TAILLE; ++i) {
    if (tab[i]%2 == 1)
      ++nbEntiersImpairs;
  }

  assert nbEntiersImpairs == 2;
}

/**
 * Écrire avec une boucle while le code permettant de compter le nombre d'entiers impairs.
 */
void exercice3() {
  int tab[] = {4, 4, 2, 9, 15, 10, 12};
  int TAILLE = 7;
  int nbEntiersImpairs = 0;
  int i = 0;

  while (i < TAILLE) {
    if (tab[i]%2 == 1)
       ++nbEntiersImpairs;
    ++i;
  }
  
  assert nbEntiersImpairs == 2;
}


/**
 * Un joueur lance un dé  :
 * il gagne 3€ s'il tombe sur 6,
 * il gagne 1€ s'il tombe sur 4 ou 5,
 * il perd 2€ s'il tombe sur 1 ou 2 ou 3.
 * Écrire le code vérifiant que le joueur a perdu 3 euros, pour la série de tirs donnée.
 */
void exercice4() {
  int lanceDe[] = {1, 2, 4, 1, 5, 6, 3};
  int TAILLE = 7;
  int somme = 0;
  
  for (int i = 0; i < TAILLE; ++i) {
    if (lanceDe[i] <= 3)
      somme -= 2;
    else if (lanceDe[i] >= 4 && lanceDe[i] <= 5)
      ++somme;
    else
      somme += 3;
  }
  
  assert somme == -3;
}


/**
 * Même exercice que le précédent, mais avec une boucle while.
 */
void exercice5() {
  int diceRoll[] = {1, 2, 4, 1, 5, 6, 3};
  int length = 7;
  int sum = 0;
  int i = 0;
  
  while (i < length) {
    if (diceRoll[i] <= 3)
      sum -= 2;
    else if (diceRoll[i] >= 4 && diceRoll[i] <= 5)
      ++sum;
    else
      sum += 3;
    ++i;
  }
  
  assert sum == -3;
}

/**
 * Deux joueurs jouent à Pierre/Feuille/Ciseau.
 * Les deux tableaux représentent les 7 parties jouées.
 * Complétez le code prouvant que le joueur 2 a gagné 3 à 2.
 */
void exercice6() {
  char joueur1[] = {'P','F','P','C','P','P','F'};
  char joueur2[] = {'F','F','C','F','P','F','C'};
  int TAILLE = 7;
  int pointsJ1 = 0;
  int pointsJ2 = 0;
  
  for (int i = 0; i < TAILLE; ++i) {
    if (joueur1[i] != joueur2[i]) {
      if((joueur1[i]=='F' && joueur2[i]=='P') ||
        (joueur1[i]=='P' && joueur2[i]=='C') ||
        (joueur1[i]=='C' && joueur2[i]=='F')) {
          ++pointsJ1;
      } else {
         ++pointsJ2;
     }
   }
  }
  
  assert pointsJ1==2 && pointsJ2==3;
}


/**
 * Refaire l'exercice précédent avec une boucle while.
 */
void exercice7() {
  char player1[] = {'P','F','P','C','P','P','F'};
  char player2[] = {'F','F','C','F','P','F','C'};
  int length = 7;
  
  int pointsJ1 = 0;
  int pointsJ2 = 0;
  
  int i = 0;
  
  while (i < length) {
    if (player1[i] != player2[i]) {
      if((player1[i]=='F' && player2[i]=='P') ||
        (player1[i]=='P' && player2[i]=='C') ||
        (player1[i]=='C' && player2[i]=='F')) {
          ++pointsJ1;
      } 
      else
         ++pointsJ2;
    }
    ++i;
  }
  
  assert pointsJ1 == 2 && pointsJ2 == 3;
}


/**
 * Le code suivant permet de comparer deux fractions et d'afficher à l'écran si elles sont égales ou pas.
 * Par exemple ici on veut vérifier que 5/2 est identique à 10/4 car 5/2 = 10/4 = 2.5
 * Le code ci-dessous affiche un résultat correct. Pourtant ce code comporte des erreurs.
 * Identifiez deux cas différents d'initialisation des 4 variables montrant que ce code contient deux erreurs.
 */
void exercice8() {
  // cas 1, à modifier
  int num1 = 5;
  int denum1 = 2;
  int num2 = 10;
  int denum2 = 3;
  if ((num1/denum1) == (num2/denum2)) {
    println("Ces deux fractions sont égales.");
  } else {
    println("Ces deux fractions sont différentes.");
  }
  // cas 2, à modifier
  int num3 = 5;
  int denum3 = 2;
  int num4 = 10;
  int denum4 = 3;
  if ((num3/denum3) == (num4/denum4)) {
    println("Ces deux fractions sont égales.");
  } else {
    println("Ces deux fractions sont différentes.");
  }  
}


/**
 * Proposez une version corrigée de l'exercice précédent qui fonctionne avec les deux cas de tests que vous avez trouvés.
 * Comparer deux "float" avec == n'est pas une bonne idée, à cause des problèmes de précision.
 * Utilisez donc le produit en croix, qui évite toute division.
 */
void exercice9() {  
}


/**
 * Le code ci-dessous doit vérifier si b est à la fois strictement plus grand que a,
 * et strictement plus petit que c.
 * Complétez-le.
 */
void exercice10() {
  int a = 2;
  int b = 3;
  int c = 4;
  boolean resultat;
  resultat = false /* Compléter ici : remplacer false par un test */;
  assert resultat;
}


/**
 * Le code suivant permet de savoir si un tableau est rangé par ordre croissant.
 * Le test réalisé passe, pourtant ce code ne fonctionne pas. 
 * 1) Trouvez un autre cas de figure mettant en évidence une deuxième erreur commise par le développeur. Le test ne doit plus passer.
 * 2) Corrigez ce code. Le test doit passer à nouveau.
 */
void exercice11() {
  int tab[] = {2, 4, 6, 9, 10, 15, 17};
  int TAILLE = 7;
  int i = 0;
  boolean croissant = false; 
  while (i<TAILLE && !croissant) {
    if (tab[i+1] < tab[i]) {
      croissant = true;
    }
    i++;
  }
  assert croissant;
}


/**
 * Ce code est supposé permettre de trouver la valeur la plus élevée dans un tableau d'entiers.
 * En utilisant le debugger, identifiez ce qui pose problème et proposez une correction.
 */
void exercice12() {
  int tab[] = {-4, -4, -2, -9, -15, -10, -12};
  int TAILLE = 7;
  int max = 0;
  for (int i=0; i<TAILLE; i++) {
    if (tab[i] > max) {
      max = tab[i];
    }
  }    
  assert max==-2;
}


/**
 * Reprenez votre code de l'exercice précédent corrigé, et remplacez la boucle for par une boucle while.
 */
void exercice13() {
}





void setup() {
  exercice0();
  exercice1();
  exercice2();
  exercice3();
  exercice4();
  exercice5();
  exercice6();
  exercice7();
  //exercice8();
  //exercice9();
  //exercice10();
  //exercice11();
  //exercice12();
  //exercice13();
  println("Tests OK.");
}
