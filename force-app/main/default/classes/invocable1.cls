public class invocable1 {
    @invocablemethod(label='creatcon' description='invocable method call')
    public static void crcontacts(list<account> lstaccounts) {
        list<contact>cclist=new list<contact>();
        for(account acc:lstaccounts) {
            if(acc.Active__c!=null) {
                contact con=new contact();
                con.FirstName='invocabletest';
                con.LastName=acc.Name;
                con.Phone=acc.Phone;
                con.AccountId=acc.id;
                cclist.add(con);
            }
        }
        database.insert(cclist,false);
    }

}