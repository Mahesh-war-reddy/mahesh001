public class wissen_vfaccsearch {
    public string header{get;set;}
    public string serch{get;set;}
    public list<account> acc{get;set;}
    public wissen_vfaccsearch() {
       header='WELCOME';
        
    }
    public void accserchmethod2() {
        acc=new list<account>();
        string query= 'select id, name , industry, phone from account where name like \'%' + serch + '\'';
        acc=database.query(query);
        system.debug(acc.size());
    }
}