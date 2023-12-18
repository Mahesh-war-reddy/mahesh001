public class wissen_queueable_1 implements Queueable {
    public void execute (QueueableContext qc) {
        list<Customer_Info__c> d=new  list<Customer_Info__c>();
        list<Customer_Info__c> del1 = [select id,Name,Ammount_Paid__c from Customer_Info__c where Name ='Mahesh1'];
for(Customer_Info__c e:del1)
{
e.Ammount_Paid__c=4000;

d.add(e);
}
    update d;    
}
}