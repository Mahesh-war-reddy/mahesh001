public class test11 {
    public static void positionstatus(list<Review__c> r) {
        for(Review__c rs:r) {
            Position1__c pos=[select id, Status__c from Position1__c where Name=:rs.Position__c Limit 1 ];
            if(pos!=Null) {
                pos.Status__c='Interviews started';
                update pos;
            }
        }
        
    }
}