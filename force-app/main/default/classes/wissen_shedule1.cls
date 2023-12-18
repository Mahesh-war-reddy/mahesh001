public class wissen_shedule1 implements schedulable {
    public void execute(SchedulableContext sc)
{
list<Dell_entity_orders__c> con=[select id,name from Dell_entity_orders__c where name='Mahesh'];
delete con;
}
}