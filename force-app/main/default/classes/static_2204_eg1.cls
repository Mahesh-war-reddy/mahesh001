public class static_2204_eg1 {
    public integer a=10; //non static accept both static and non static 
    public static integer b=10;
    public void aaa() {
      System.debug(a);
        System.debug(b);
    }
    public static void bbb() {
     //  System.debug(a);
        System.debug(b);
 }

}