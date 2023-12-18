public class wissen_queueable_2 implements Queueable{
public void execute(queueablecontext qcl) {
    list<Customer_Info__c> aa=new  list<Customer_Info__c>();
   
list<Customer_Info__c> del2 = [select id,Name,EMAIL__c from Customer_Info__c where Name='Mahesh1'];
for(Customer_Info__c e2:del2) {
e2.EMAIL__c='m@mmail.com';
aa.add(e2);

}
    update aa;
system.enqueueJob(new wissen_queueable_1());


}
   
}
//calling first job from second job

//string jobid=system.enqueueJob(new wissen_queueable_2());
//system.debug('@jobid' + jobid);//generates id