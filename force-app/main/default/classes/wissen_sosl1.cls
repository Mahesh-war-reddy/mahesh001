public class wissen_sosl1 {
//finding a string in all fields    
    public static void method11() {
List<List<SObject>> srch1 = [FIND 'mahesh' IN ALL FIELDS
RETURNING Dell_entity_orders__c(Name), Customer_Info__c(Name)];
system.debug(srch1);


}
    //finding string in fields
public static void method12(){
    List<List<SObject>> srch1 = [FIND 'mahesh' IN Name FIELDS
RETURNING Dell_entity_orders__c(Name), Customer_Info__c(Name)];



}
    //finding string in email
    
    public static void method13(){
    List<List<SObject>> srch1 = [FIND 'mahesh' IN email FIELDS
RETURNING Dell_entity_orders__c(Name), Customer_Info__c(Name)];

    
}
}