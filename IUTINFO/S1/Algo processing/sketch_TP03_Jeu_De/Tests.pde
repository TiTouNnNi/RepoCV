// tests de la fonction somme()
void test_somme()
{
  println("--- Test somme ---");
  int s;
  
  int[] j1 = {4, 2, 5, 1};
  s = somme(j1);
  assert(s==11);

  int[] j2 = {1};
  s = somme(j2);
  assert(s==0);
}

void test_yAfficherJets()
{
  assert yAfficherJets(1) == 20;
  assert yAfficherJets(2) == 40;
}

void test_yScore()
{
  assert yScore(1) == 170;
  assert yScore(2) == 190;
}


void test_stockerJet()
{
  joueurCourant = 1;
  nbJets1 = 0;
  jets1 = new int[NB_JETS_MAX];
  nbJets2 = 0;
  jets2 = new int[NB_JETS_MAX];
  stockerJet(4);
  assert nbJets1 == 1 && nbJets2 == 0;
  assert jets1[0] == 4;
  stockerJet(2);
  assert nbJets1 == 2 && nbJets2 == 0;
  assert jets1[0] == 4 && jets1[1] == 2;
  joueurCourant = 2;
  stockerJet(3);
  assert nbJets1 == 2 && nbJets2 == 1;
  assert jets1[0] == 4 && jets1[1] == 2 && jets2[0] == 3;
}


void test_changerDeJoueur() {
  joueurCourant = 1;
  changerDeJoueur();
  assert joueurCourant == 2;
  changerDeJoueur();
  assert joueurCourant == 1;
}
