public class wissen_testsetuponlead {
    public static void createLead() {
List<Lead> lstLead = new List<Lead>();
for(Integer i = 0 ; i<5 ; i++) {

lstLead.add(new Lead(lastName = 'testLName'+i , Company = 'Salesforce'));
}
insert lstLead ;
system.debug(lstLead);
}
}