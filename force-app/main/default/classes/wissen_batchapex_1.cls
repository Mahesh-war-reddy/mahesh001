global class wissen_batchapex_1 implements database.Batchable<sobject> {
    global database.QueryLocator start(database.BatchableContext BC) {
     String query = 'SELECT Id,Name FROM Dell_individual_Customer_Info__c';
return Database.getQueryLocator(query);   
    }
    global void execute(Database.BatchableContext BC, List<Dell_individual_Customer_Info__c> dell1) {

// process each batch of records

for(Dell_individual_Customer_Info__c e : dell1)
{
// Update the  Name
e.Name = e.Name + 'Ltd';
}
try {
// Update the  Record
update dell1;

} catch(Exception e) {
System.debug(e);
}

}

global void finish(Database.BatchableContext BC) {
// execute any post-processing operations
}
}