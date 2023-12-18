public class candidateinformation01 {
    public static void c(){
        list<Candidate_Information__c>v=[select id from Candidate_Information__c limit 1];
        system.debug('ff'+v);
    }

}