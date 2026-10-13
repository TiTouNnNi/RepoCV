int NOMBRE_DE_LIGNES = 3;
int NOMBRE_ALLUMETTES_PAR_LIGNE = 10;

void setup() {
  int[] nbAllumettesLigne = new int[NOMBRE_DE_LIGNES]; 
  int[] nombreAllumette = new int[NOMBRE_ALLUMETTES_PAR_LIGNE]; 
  boolean partieTerminee = false;
  int numJoueur = 1;
  initTabAllummettes(nbAllumettesLigne);
  afficherUneLigne(NOMBRE_ALLUMETTES_PAR_LIGNE);
  afficherPlateau(nbAllumettesLigne);
}
void initTabAllummettes(int[] tab){
  for(int i=0;i<NOMBRE_DE_LIGNES;i++){
    tab[i]=NOMBRE_ALLUMETTES_PAR_LIGNE;
  }
}
void afficherUneLigne(int nombreAllumette){
  for (int j=0;j<nombreAllumette;j++)
    print("| "); 
}
void afficherPlateau(int[] tab){
  println("Plateau de jeu");
  for(int u=0;u<NOMBRE_DE_LIGNES;u++){;
    afficherUneLigne(tab[u]);
    println();
    }
}  
int choisirLigne(int[] tab){
  int numLigne=(int)random(0,3);
  while(tab[numLigne]==0){
    numLigne=(int)random(0,3);
  }
  return numLigne;
}
//int RetirerAllummette(int[] tab){
//  int nbraRetirer=(int)random(1,4);
//  if(nbraRetirer>nbAllumettesLigne[numLigne]){
//    nbraRetirer=nbAllumettesLigne[numLigne];
//  }

//}
