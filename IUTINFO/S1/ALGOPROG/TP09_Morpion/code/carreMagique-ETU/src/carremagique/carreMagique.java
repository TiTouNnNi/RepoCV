package carremagique;

/**
 * Carré magique.
 */
public class carreMagique {

    /**
     * Fonction principale.
     *
     * @param args arguments de la ligne de commande
     */
    public static void main(String[] args) {
        int[][] carre = {{-1, -1, -1}, {-1, -1, -1}, {-1, -1, -1}};
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                carre[i][j] = requeteCarre.getVal(1, 5, i, j);
                System.out.print(carre[i][j] + " ");
            }
            System.out.println(" ");
        }
    }
}
