public class test31 {
    @AuraEnabled
    Public Static List<Account> getacc(String searchtext) {
        string c= 'Select ID,Name,Phone,Fax,Rating,Industry from Account where name like \'%'+searchtext+'%\'' ;
            list<Account> acc1=Database.query(c);
        Return acc1;
    }
}