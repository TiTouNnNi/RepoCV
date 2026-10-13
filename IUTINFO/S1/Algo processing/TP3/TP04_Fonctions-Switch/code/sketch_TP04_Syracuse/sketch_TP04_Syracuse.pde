void setup() //<>//
{
  int u_n;
  boolean vol_atteint;

  // premier terme de la suite (valeur entière positive)
  u_n = (int)random(1, 100);
  print(u_n, " ");

  // calcul des termes suivants
  vol_atteint = (u_n == 1);
  while (!vol_atteint) {
    u_n = suivant(u_n);
    print(u_n, " ");
  }
}

// terme suivant de la suite
int suivant(int n)
{
  int res;
  if (n%2 == 0) {
    res = n/2;
  } else {
    res = 3*n + 1;
  }
  return res;
}