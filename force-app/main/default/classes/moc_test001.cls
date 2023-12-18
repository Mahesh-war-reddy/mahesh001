public class moc_test001 {
    public static void query001(){
        for(indigofeedback__c fed:[select name ,Status__c from indigofeedback__c where Status__c='Unhappy']){
            fed.Status__c='Happy';
            update fed;
            system.debug(fed);
        } 
    }

}