public class interview_auto {
  

public Interview__c inter{get;set;}
public interview_auto(ApexPages.StandardController stdController){
inter = (Interview__c) stdController.getRecord();
}
public void getautopopultevalue( ) {
Applications__c job = [select id, Name, Candidate__c, Position__c from Applications__c where id=:inter.Application__c ];
inter.Candidate__c = job.Candidate__c;
inter.Position1__c = job.Position__c;
}
}