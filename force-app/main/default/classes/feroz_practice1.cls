public class feroz_practice1 {
    public static void conlist() {
       // list<account> acc=[select id,name from account];
       // if(! acc.isempty()){
            for(account a:[select id,name from account]) {
             system.debug(a);   
          //  }
        }
        
    }

}