@istest(seealldata=true)
public class wissen_testalldata1 {
static testmethod void testMethodFirst() {

Dell_entity_orders__c obj = [SELECT Id, Name from Dell_entity_orders__c LIMIT 1];
system.debug(obj);

}
}