public with sharing class Lwc_datatable_con {
    @AuraEnabled(cacheable=true)
    public static List<contact>cc(){
        Return [Select Id,Name,Phone,Email from Contact];
       
    }
   
}