package td2;

import java.util.HashMap;

public class Catalog {

    private static HashMap<Product, Integer> cata;


    public static void addProductToCatalog(Product product, int quantity){
        cata.put(product, quantity);
    }

    public static boolean isInCatalog(Product product){
        return cata.containsKey(product);
    }

    public static int nmbInCatalog(Product product){
        return cata.get(product);
    }

    public static void removeFromCatlog(Product product, int quantity){
        cata.replace(product, nmbInCatalog(product)-quantity);
    }
}
