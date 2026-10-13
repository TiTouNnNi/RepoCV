package td2;

public class UnitProduct extends Product{

    private int unit_nmb;

    public UnitProduct(String name, int price, float vat, int unit_nmb) {
        super(name, price, vat);
        this.unit_nmb = unit_nmb;
        //TODO Auto-generated constructor stub
    }

    @Override
    public int getPriceExcludingVAT(){
        return this.price * this.unit_nmb;
    }

    @Override
    public float getPriceIncludingVAT(){
        int val = this.price * this.unit_nmb;
        return val + (val * this.vat/100);
    }

}
