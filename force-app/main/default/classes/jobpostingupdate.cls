Global class jobpostingupdate implements Schedulable {
    global void execute (schedulablecontext sc) {
        list<Job_Posting__c> jp=[select id,Expiry_date__c,Status__c,Position1__r.Status__c,Position1__r.Close_Date__c from Job_Posting__c where Status__c ='Expired'];
        for( Job_Posting__c jpp:jp) {
            if(jpp.Position1__r.Status__c !='Closed - Filled' || jpp.Position1__r.Status__c !='Closed - Not Approved ' || jpp.Position1__r.Status__c !='Closed - Canceled' ) {
                jpp.Status__c='Open';
            }
            update jp;
        }
}
}