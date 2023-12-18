public class test33 {
    public static void extendoffer(list<Applications__c> appa) {
        for(Applications__c a:appa) {
            if(a.Average_Rating__c >=4 && a.Number_of_Reviews__c >=3) {
                a.Status__c='Extend Offer';
            }
        }
    }
}