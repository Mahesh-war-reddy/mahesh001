public class interviewnotsame{
    public static void intrtime(list<Interview__c> inpt) {
        for(Interview__c ei:inpt) {
            list<Interview__c> oldint=[select id,Interview_Start__c,Interview_End__c from Interview__c where Interviewers__c=:ei.Interviewers__c];
            for(Interview__c oldinti:oldint){
                
            
            if((ei.Interview_Start__c >= oldinti.Interview_Start__c && ei.Interview_End__c <=oldinti.Interview_End__c) ||(ei.Interview_Start__c >=oldinti.Interview_Start__c && ei.Interview_Start__c <=oldinti.Interview_End__c)) {
                
                ei.Interview_Start__c.adderror('He has already assigned to that same slot try anouther interviewr or try in next slot after 4hrs');
            }
            }
        }
    }

}