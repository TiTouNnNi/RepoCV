package td2;

public class ServiceProduct extends Product {

    private int service_nmb;

    public ServiceProduct(String name, int price, float vat, int service_nmb) {
        super(name, price, vat);
        this.service_nmb= service_nmb;
        //TODO Auto-generated constructor stub
    }

    @Override
    public int getPriceExcludingVAT(){
        return this.price * this.service_nmb;
    }

    @Override
    public float getPriceIncludingVAT(){
        int val = this.price * this.service_nmb;
        return val + (val * this.vat/100);
    }

}
