package td2;

import java.util.HashSet;

public class Product {

    protected String name;
    protected static HashSet<String> allNames;
    protected int price;
    protected float vat;

    public Product(String name, int price, float vat){
        Product newProduct = new Product(name, price, vat);
        if (!allNames.contains(name)){
            allNames.add(name);
            this.name = name;
            this.price = price;
            this.vat = vat;
            Catalog.addProductToCatalog(newProduct, 0 );
        } else {
            Catalog.addProductToCatalog(newProduct, Catalog.nmbInCatalog(newProduct)+1);
            throw new IllegalArgumentException("Le produit existe déjà");
        }
    } 

    public int getPriceExcludingVAT(){
        return this.price;
    }

    public float getVATAmount(){
        return this.vat;
    }

    public float getPriceIncludingVAT(){
        return this.price + (this.price * this.vat/100);
    }
}
