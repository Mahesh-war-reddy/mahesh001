@istest
private class wissen_gst1 {
    static testMethod void testgst() {
Dell_entity_orders__c d = new Dell_entity_orders__c(Name='Mahesh', sell_price__c=100000);
System.debug('Price before inserting new property: ' + d.sell_price__c);

Test.startTest(); //
// Insert property
insert d;

Test.stopTest(); //to make sure operation is completed

// Retrieve the new property
d = [SELECT sell_price__c FROM Dell_entity_orders__c WHERE Id =:d.Id];
System.debug('Price after trigger fired: ' + d.sell_price__c);

// Test that the trigger correctly updated the price
System.assertEquals(80000, d.sell_price__c);
}




}