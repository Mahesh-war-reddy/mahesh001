public class rupom_datatable_helperjs1 {
    @AuraEnabled
    public Static List<Account> getsearchacc(String searchtext) {
        String Qu = 'select Id,Name,Phone,Fax,Rating,Industry from Account where name like \'%'+searchtext+'%\'' ;
        List<Account> accs = Database.query(Qu);
        Return accs;
    }

}