public class vid_25_batchape implements database.Batchable<sobject> {
    public database.querylocator start(database.batchablecontext bc) { //used to drag data
        string qr = 'select id from applicant__c' ;
        return database.getquerylocator(qr);
    }
    public void execute(database.batchablecontext bc,list<applicant__c> mydata) { //to process data
       // delete mydata;
        list<applicant__c> bin =new list<applicant__c>();
        for(applicant__c eo:mydata) {
            eo.name= 'surgical strike' ;
            bin.add(eo);
            
        } 
        update bin;
    }  
    public void finish(database.batchablecontext bc) { //send mails
        
    }
}