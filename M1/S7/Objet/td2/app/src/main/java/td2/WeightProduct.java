package td2;

public class WeightProduct extends Product {

    private int weight;

    public WeightProduct(String name, int price, float vat, int weight) {
        super(name, price, vat);
        this.weight = weight;
        //TODO Auto-generated constructor stub
    }

    @Override
    public int getPriceExcludingVAT(){
        return this.price * this.weight;
    }

    @Override
    public float getPriceIncludingVAT(){
        int val = this.price * this.weight;
        return val + (val * this.vat/100);
    }
}
