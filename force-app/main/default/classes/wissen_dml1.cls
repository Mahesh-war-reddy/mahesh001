public class wissen_dml1 {
    public void method1(){
        list<Dell_entity_orders__c> d1=[select Name from Dell_entity_orders__c limit 1 ];
        for(Dell_entity_orders__c a:d1) {
         
            a.Name='mr' +a;
            update d1;
            system.debug(d1);
            //delete d1;
            //undelete d1;
        }
    }
}