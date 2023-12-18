public without sharing class task1wissen {
    @auraEnabled
    public static list<wissentask1__c>searchmethod1(string Strkey){
       string searchkey='%'+Strkey+'%';
        //query can be done if search key matches any of the field data in the object.
      return [select name,Value__c,Product_Description__c,sno__c from wissentask1__c where name like:searchkey or Value__c like:searchkey or sno__c like:searchkey] ;
    }
}