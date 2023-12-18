public class wissen_trycatch1 {
    public static void method3() {
        try {
        Dell_entity_orders__c d = new Dell_entity_orders__c();
           
        insert d;
        } catch(DmlException e) {
            system.debug('error ' + e.getMessage());
        }
    }

}