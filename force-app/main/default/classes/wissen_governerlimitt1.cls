public class wissen_governerlimitt1 {
     public static void method13() {
       list<Dell_entity_orders__c>dell_in= new list<Dell_entity_orders__c>();
         for(integer i=1;i<=1000;i++) {
           
            Dell_entity_orders__c d=new Dell_entity_orders__c();
            d.Name='Mahesh DML' +i;
            //ll_in.add(d);
             insert d;
             system.debug(d);
        
         }
        }
        
 }