package td2;

public class VolumeProduct extends Product{

    private int volume;

    public VolumeProduct(String name, int price, float vat, int volume) {
        super(name, price, vat);
        this.volume = volume;
        //TODO Auto-generated constructor stub
    }

    @Override
    public int getPriceExcludingVAT(){
        return this.price * this.volume;
    }

    @Override
    public float getPriceIncludingVAT(){
        int val = this.price * this.volume;
        return val + (val * this.vat/100);
    }

}
