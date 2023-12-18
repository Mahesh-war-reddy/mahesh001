public class test22 {
    public static void positionclosed(list<Applications__c> app) {
        for(Applications__c a:app) {
            Position1__c vac=[select Vacancies__c,Status__c from Position1__c where id=:a.Position__c ];
            list<Applications__c > ap=[select id,Name from Applications__c where Position__c=:a.Position__c and Status__c='Hired' ];
            if(ap.size()>=vac.Vacancies__c) {
                vac.Status__c='Closed - Filled';
                vac.Close_Date__c=system.today();
                
            }
            update vac;
        }
    }

}