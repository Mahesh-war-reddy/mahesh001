//future quable
public class future_eg1 {
    @future
    public static void changopp()
    {
        list<operation__c> ol =[select id, name from operation__c ];
        for(operation__c ed:ol) {
            ed.name='future';
            update ed;
        }
            
    }

}