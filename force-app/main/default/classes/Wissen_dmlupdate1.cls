public with sharing class Wissen_dmlupdate1 {
    public static void method1(){
        list<Dell_entity_orders__c> a=[ select Name from Dell_entity_orders__c];
        for (Dell_entity_orders__c de:a) {
            de.Name='mr'+ de.Name;
        }
        update a;
        system.debug(a);
    }
}