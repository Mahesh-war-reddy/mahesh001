@istest
public class wissen_testlead1 {
    static void createLead(){
    List<Lead> lstLead = new List<Lead>();

for(Integer i = 0 ; i<5 ; i++) {
lstLead.add(new Lead(lastName = 'testLName'+i , Company = 'Salesforce'));
}
insert lstLead ;
system.debug(lstLead);
}
//Check whether records created in test method
//is accessible or not
public static testMethod void test(){

System.assertEquals(5, [SELECT COUNT() FROM Lead Where company = 'Salesforce']);
}
}