public class wissen_queabletrigger_concre1 implements queueable {
    private List<Account> acc1;
public wissen_queabletrigger_concre1(List<Account> acc2){
this.acc1=acc2;
}
public void execute(QueueableContext qCntxt) {
List<Contact> con1 =new List<Contact>();
//Loop on all accounts that are inserted.
for(Account acc:acc1) {
Contact con= new Contact();
con.LastName=acc.Name;
con.AccountId=acc.Id;
con1.add(con); //Add each Contact to List
}
if(con1.size()>0)
{
Insert con1;
}
}
}