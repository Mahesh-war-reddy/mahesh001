public class wissen_database_dml {
   
public static void method3() 
{
List<Dell_entity_orders__c> d = new List<Dell_entity_orders__c>();
d.add( new Dell_entity_orders__c(Name='Mahesh'));
d.add( new Dell_entity_orders__c(sell_price__c=80.0));
d.add( new Dell_entity_orders__c());
// database.DML statement
Database.insert(d,false);
system.debug(d);


}

}