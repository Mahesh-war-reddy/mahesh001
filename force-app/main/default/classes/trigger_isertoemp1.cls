public class trigger_isertoemp1 {
    public static void usertoappl(list<user> nu) {
        for (user eu:nu) {
            applicant__c ap=new applicant__c();
            ap.Name= eu.Username;
            insert ap;
        }
    }

}