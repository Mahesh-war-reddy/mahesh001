public class wissen_trycatch_1 {
    public static void method1() {
        try{
            account d=new account();
            insert d;
        } catch (DmlException e) {
            system.debug( e.getMessage());
        }
        finally {
            system.debug('it is final');
      }
    }

}