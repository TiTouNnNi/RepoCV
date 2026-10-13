package td2;

import java.util.HashMap;

public class Basket {

    private HashMap<Product,Integer> basket;

    public void addToBasket(Product product, int quantity){
        if (Catalog.isInCatalog(product) && Catalog.nmbInCatalog(product)>quantity){
            basket.put(product, quantity);
            Catalog.removeFromCatlog(product, quantity);
        }
    }

}
