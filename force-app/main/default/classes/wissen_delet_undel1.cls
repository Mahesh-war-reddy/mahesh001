public without sharing class wissen_delet_undel1 {
    public static void method1() {
        list<Dell_entity_orders__c>dd=[select Id,Name from Dell_entity_orders__c limit 2];
        system.debug(dd);
        delete dd;
        undelete dd;
        
    }
  

}