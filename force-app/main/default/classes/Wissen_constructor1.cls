public class Wissen_constructor1 {
     public integer l;
     public integer b;
    public Wissen_constructor1(integer x, integer y) {
        l=x;
        b=y;
    }
    public void areacal() {
        integer r;
        r=l*b;
        System.debug('the area is'+r);
    }

}